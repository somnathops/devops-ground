import express from 'express';
import path from 'path';
import notesRouter from './routes/notes';

const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json());
app.use(express.static(path.join(__dirname, '../public')));

app.get('/health', (req, res) => {
  res.json({ status: 'ok', uptime: process.uptime() });
});

app.use('/notes', notesRouter);

app.listen(PORT, () => {
  console.log(`Notes API running on port ${PORT}`);
});
