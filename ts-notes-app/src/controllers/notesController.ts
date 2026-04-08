import { Request, Response } from 'express';
import { v4 as uuidv4 } from 'uuid';
import { Note } from '../models/note';

const notes: Note[] = [];

export const getAllNotes = (req: Request, res: Response): void => {
  res.json(notes);
};

export const getNoteById = (req: Request, res: Response): void => {
  const note = notes.find(n => n.id === req.params.id);
  if (!note) {
    res.status(404).json({ error: 'Note not found' });
    return;
  }
  res.json(note);
};

export const createNote = (req: Request, res: Response): void => {
  const { title, content } = req.body;
  if (!title || !content) {
    res.status(400).json({ error: 'title and content are required' });
    return;
  }
  const note: Note = {
    id: uuidv4(),
    title,
    content,
    createdAt: new Date(),
    updatedAt: new Date()
  };
  notes.push(note);
  res.status(201).json(note);
};

export const updateNote = (req: Request, res: Response): void => {
  const index = notes.findIndex(n => n.id === req.params.id);
  if (index === -1) {
    res.status(404).json({ error: 'Note not found' });
    return;
  }
  const { title, content } = req.body;
  notes[index] = { ...notes[index], title, content, updatedAt: new Date() };
  res.json(notes[index]);
};

export const deleteNote = (req: Request, res: Response): void => {
  const index = notes.findIndex(n => n.id === req.params.id);
  if (index === -1) {
    res.status(404).json({ error: 'Note not found' });
    return;
  }
  notes.splice(index, 1);
  res.status(204).send();
};
