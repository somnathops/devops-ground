import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from apscheduler.schedulers.background import BackgroundScheduler
from datetime import datetime
from dotenv import load_dotenv
from flask import Flask, request, jsonify, render_template
import os
import json

app = Flask(__name__)
load_dotenv()

DATA_FILE = 'data/birthday_data.json'


def load_birthdays():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, 'r') as f:
        return json.load(f)


def save_birthdays(birthdays):
    os.makedirs('data', exist_ok=True)
    with open(DATA_FILE, 'w') as f:
        json.dump(birthdays, f, indent=2)


def check_birthdays():
    today = datetime.now().strftime('%m-%d')  # today's date as MM-DD
    birthdays = load_birthdays()

    for person in birthdays:
        if person['birthday'] == today:
            print(f"Sending birthday email to {person['name']}...")
            send_birthday_email(person['name'], person['email'])
            print(f"Sent to {person['email']}!")


def send_birthday_email(name, email):
    sender = os.getenv('EMAIL_SENDER')
    password = os.getenv('EMAIL_PASSWORD')

    # Build the email
    msg = MIMEMultipart()
    msg['From'] = sender
    msg['To'] = email
    msg['Subject'] = f'Happy Birthday {name}!'

    body = f"""
    Dear {name},

    Wishing you a very Happy Birthday! 🎂

    Hope your day is filled with joy and happiness.

    Best wishes!
      """

    msg.attach(MIMEText(body, 'plain'))

    # Send via Gmail SMTP
    with smtplib.SMTP_SSL('smtp.gmail.com', 465) as server:
        server.login(sender, password)
        server.sendmail(sender, email, msg.as_string())


@app.route('/')
def home():
    return render_template('index.html')


@app.route('/health')
def health():
    return jsonify({'status': 'ok'})


@app.route('/birthdays', methods=['GET'])
def get_birthdays():
    return jsonify(load_birthdays())


@app.route('/birthdays', methods=['POST'])
def add_birthday():
    data = request.get_json()
    if not data.get('name') or not data.get('email') or not data.get('birthday'):
        return jsonify({'error': 'name, email and birthday are required'}), 400
    birthdays = load_birthdays()
    birthdays.append({
        'name': data['name'],
        'email': data['email'],
        'birthday': data['birthday']    # format: MM-DD
    })
    save_birthdays(birthdays)
    return jsonify({'message': 'Birthday added!'}), 201


@app.route('/birthdays/<int:index>', methods=['DELETE'])
def delete_birthday(index):
    birthdays = load_birthdays()
    if index < 0 or index >= len(birthdays):
        return jsonify({'error': 'Not found'}), 404
    birthdays.pop(index)
    save_birthdays(birthdays)
    return jsonify({'message': 'Deleted!'}), 200

@app.route('/send-test-email', methods=['POST'])
def test_email():
    data = request.get_json()
    try:
        send_birthday_email(data['name'], data['email'])
        return jsonify({'message': f"Email sent to {data['email']}!"}), 200
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/check-birthdays', methods=['GET'])
def trigger_check():
    check_birthdays()
    return jsonify({'message': 'Birthday check done!'})


if __name__ == '__main__':
    scheduler = BackgroundScheduler()
    scheduler.add_job(check_birthdays, 'cron', hour=9, minute=0)  # runs every day at 9am
    scheduler.start()
    print("Scheduler started — will check birthdays daily at 9am")
    app.run(host='0.0.0.0', port=5001, debug=True, use_reloader=False)
