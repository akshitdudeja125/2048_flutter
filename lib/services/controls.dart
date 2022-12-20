import 'dart:math';
import 'package:tuple/tuple.dart';

int n = 4;

List<List<int>> generateGrid() {
  final List<List<int>> grid = List<List<int>>.generate(
    n,
    (int index) => List<int>.generate(n, (int index) => 0),
  );
  return grid;
}

bool compareGrids(List<List<int>> grid1, List<List<int>> grid2) {
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      if (grid1[x][y] != grid2[x][y]) {
        return false;
      }
    }
  }
  return true;
}

List<List<int>> copyGrid(List<List<int>> grid) {
  final List<List<int>> extraGrid = List<List<int>>.generate(
    n,
    (int index) => List<int>.generate(n, (int index) => 0),
  );
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      extraGrid[x][y] = grid[x][y];
    }
  }
  return extraGrid;
}

List<List<int>> generateNewGrid() {
  final List<List<int>> grid = generateGrid();
  addRandomTile(grid);
  addRandomTile(grid);
  return grid;
}

void addRandomTile(List<List<int>> grid) {
  final List<Point> availableCells = getAvailableCells(grid);
  if (availableCells.isNotEmpty) {
    final Point point = availableCells[Random().nextInt(availableCells.length)];

    grid[point.x.toInt()][point.y.toInt()] = Random().nextInt(10) == 0 ? 4 : 2;
  }
}

List<Point> getAvailableCells(List<List<int>> grid) {
  final List<Point> availableCells = <Point>[];
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      if (grid[x][y] == 0) {
        availableCells.add(Point(x, y));
      }
    }
  }
  return availableCells;
}

bool isGameOver(List<List<int>> grid) {
  if (getAvailableCells(grid).isNotEmpty) {
    return false;
  }
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      if (x != n - 1 && grid[x][y] == grid[x + 1][y]) {
        return false;
      }
      if (y != n - 1 && grid[x][y] == grid[x][y + 1]) {
        return false;
      }
    }
  }
  return true;
}

bool isGameWon(List<List<int>> grid) {
  for (int x = 0; x < n; x++) {
    for (int y = 0; y < n; y++) {
      if (grid[x][y] == 2048) {
        return true;
      }
    }
  }
  return false;
}

Tuple5<int, int, int, List<List<int>>, List<List<int>>> moveDownAndMerge(
    int score,
    int highScore,
    int previousScore,
    List<List<int>> grid,
    List<List<int>> previousGrid) {
  final List<List<int>> newGrid = copyGrid(grid);
  previousScore = score;
  for (int i = 0; i < n; i++) {
    for (int j = n - 1; j >= 0; j--) {
      if (newGrid[i][j] != 0) {
        int k = j;
        while (k + 1 < n && newGrid[i][k + 1] == 0) {
          k++;
        }
        if (k != j) {
          newGrid[i][k] = newGrid[i][j];
          newGrid[i][j] = 0;
        }
        if (k + 1 < n && newGrid[i][k + 1] == newGrid[i][k]) {
          newGrid[i][k + 1] *= 2;
          score += newGrid[i][k + 1];
          newGrid[i][k] = 0;
        }
      }
    }
  }
  if (!compareGrids(grid, newGrid)) addRandomTile(newGrid);
  return Tuple5(score, max(score, highScore), previousScore, newGrid, grid);
}

Tuple5<int, int, int, List<List<int>>, List<List<int>>> moveUpAndMerge(
    int score,
    int highScore,
    int previousScore,
    List<List<int>> grid,
    List<List<int>> previousGrid) {
  final List<List<int>> newGrid = copyGrid(grid);
  previousScore = score;
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (newGrid[i][j] != 0) {
        int k = j;
        while (k - 1 > -1 && newGrid[i][k - 1] == 0) {
          k--;
        }
        if (k != j) {
          newGrid[i][k] = newGrid[i][j];
          newGrid[i][j] = 0;
        }
        if (k - 1 > -1 && newGrid[i][k - 1] == newGrid[i][k]) {
          newGrid[i][k - 1] *= 2;
          score += newGrid[i][k - 1];
          newGrid[i][k] = 0;
        }
      }
    }
  }
  if (!compareGrids(grid, newGrid)) addRandomTile(newGrid);
  return Tuple5(score, max(score, highScore), previousScore, newGrid, grid);
}

Tuple5<int, int, int, List<List<int>>, List<List<int>>> moveLeftAndMerge(
    int score,
    int highScore,
    int previousScore,
    List<List<int>> grid,
    List<List<int>> previousGrid) {
  previousScore = score;
  final List<List<int>> newGrid = copyGrid(grid);
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (newGrid[i][j] != 0) {
        int k = i;
        while (k - 1 > -1 && newGrid[k - 1][j] == 0) {
          k--;
        }
        if (k != i) {
          newGrid[k][j] = newGrid[i][j];
          newGrid[i][j] = 0;
        }
        if (k - 1 > -1 && newGrid[k - 1][j] == newGrid[k][j]) {
          newGrid[k - 1][j] *= 2;
          score += newGrid[k - 1][j];
          newGrid[k][j] = 0;
        }
      }
    }
  }
  if (!compareGrids(grid, newGrid)) addRandomTile(newGrid);
  return Tuple5(score, max(score, highScore), previousScore, newGrid, grid);
}

Tuple5<int, int, int, List<List<int>>, List<List<int>>> moveRightAndMerge(
    int score,
    int highScore,
    int previousScore,
    List<List<int>> grid,
    List<List<int>> previousGrid) {
  previousScore = score;
  final List<List<int>> newGrid = copyGrid(grid);
  for (int i = n - 1; i >= 0; i--) {
    for (int j = 0; j < n; j++) {
      if (newGrid[i][j] != 0) {
        int k = i;
        while (k + 1 < n && newGrid[k + 1][j] == 0) {
          k++;
        }
        if (k != i) {
          newGrid[k][j] = newGrid[i][j];
          newGrid[i][j] = 0;
        }
        if (k + 1 < n && newGrid[k + 1][j] == newGrid[k][j]) {
          newGrid[k + 1][j] *= 2;
          score += newGrid[k + 1][j];
          newGrid[k][j] = 0;
        }
      }
    }
  }
  if (!compareGrids(grid, newGrid)) addRandomTile(newGrid);
  return Tuple5(score, max(score, highScore), previousScore, newGrid, grid);
}
