package main

import "fmt"

type Member struct {
	Name  string
	Email string
	Phone string
}

func greet(m Member) string {
	return "Hello, Welcome to the Gym, " + m.Name + "!"
}

func main() {
	member := Member{
		Name: "John Doe",
		// Email: "imsomnath96@gmail.com",
		Phone: "123-456-7890",
	}
	message := greet(member)
	fmt.Println(message)
}
