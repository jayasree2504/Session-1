const grid = document.getElementById('grid');
const info = document.getElementById('info');
const restartBtn = document.getElementById('restart');

let currentPlayer = 'X';
let board = ['', '', '', '', '', '', '', '', ''];
const winningCombinations = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
    [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
    [0, 4, 8], [2, 4, 6]             // Diagonals
];

function createGrid() {
    grid.innerHTML = '';
    board.forEach((cell, index) => {
        const div = document.createElement('div');
        div.classList.add('cell');
        div.dataset.index = index;
        div.textContent = cell;
        div.addEventListener('click', handleCellClick);
        grid.appendChild(div);
    });
}

function handleCellClick(event) {
    const index = event.target.dataset.index;
    if (board[index] !== '') return;

    board[index] = currentPlayer;
    event.target.textContent = currentPlayer;

    if (checkWinner()) {
        info.textContent = `Player ${currentPlayer} Wins!`;
        highlightCells(checkWinner());
        disableGrid();
        return;
    }

    if (board.every(cell => cell !== '')) {
        info.textContent = `It's a Draw!`;
        return;
    }

    currentPlayer = currentPlayer === 'X' ? 'O' : 'X';
    info.textContent = `Player ${currentPlayer}'s Turn`;
}

function checkWinner() {
    return winningCombinations.find(combination => {
        const [a, b, c] = combination;
        return board[a] && board[a] === board[b] && board[a] === board[c];
    });
}

function highlightCells(combination) {
    combination.forEach(index => {
        grid.children[index].classList.add('highlight');
    });
}

function disableGrid() {
    Array.from(grid.children).forEach(cell => cell.classList.add('disabled'));
}

function restartGame() {
    board = ['', '', '', '', '', '', '', '', ''];
    currentPlayer = 'X';
    info.textContent = `Player X's Turn`;
    createGrid();
}

restartBtn.addEventListener('click', restartGame);

createGrid();
