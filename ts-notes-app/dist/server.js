"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const path_1 = __importDefault(require("path"));
const notes_1 = __importDefault(require("./routes/notes"));
const app = (0, express_1.default)();
const PORT = process.env.PORT || 3000;
app.use(express_1.default.json());
app.use(express_1.default.static(path_1.default.join(__dirname, '../public')));
app.get('/health', (req, res) => {
    res.json({ status: 'ok', uptime: process.uptime() });
});
app.use('/notes', notes_1.default);
app.listen(PORT, () => {
    console.log(`Notes API running on port ${PORT}`);
});
