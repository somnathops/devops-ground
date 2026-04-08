"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.deleteNote = exports.updateNote = exports.createNote = exports.getNoteById = exports.getAllNotes = void 0;
const uuid_1 = require("uuid");
const notes = [];
const getAllNotes = (req, res) => {
    res.json(notes);
};
exports.getAllNotes = getAllNotes;
const getNoteById = (req, res) => {
    const note = notes.find(n => n.id === req.params.id);
    if (!note) {
        res.status(404).json({ error: 'Note not found' });
        return;
    }
    res.json(note);
};
exports.getNoteById = getNoteById;
const createNote = (req, res) => {
    const { title, content } = req.body;
    if (!title || !content) {
        res.status(400).json({ error: 'title and content are required' });
        return;
    }
    const note = {
        id: (0, uuid_1.v4)(),
        title,
        content,
        createdAt: new Date(),
        updatedAt: new Date()
    };
    notes.push(note);
    res.status(201).json(note);
};
exports.createNote = createNote;
const updateNote = (req, res) => {
    const index = notes.findIndex(n => n.id === req.params.id);
    if (index === -1) {
        res.status(404).json({ error: 'Note not found' });
        return;
    }
    const { title, content } = req.body;
    notes[index] = { ...notes[index], title, content, updatedAt: new Date() };
    res.json(notes[index]);
};
exports.updateNote = updateNote;
const deleteNote = (req, res) => {
    const index = notes.findIndex(n => n.id === req.params.id);
    if (index === -1) {
        res.status(404).json({ error: 'Note not found' });
        return;
    }
    notes.splice(index, 1);
    res.status(204).send();
};
exports.deleteNote = deleteNote;
