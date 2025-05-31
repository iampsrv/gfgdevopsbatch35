# tests/test_calculator.py

import pytest
from app.calculator import add, subtract, multiply, divide


def test_add():
    assert add(2, 3) == 5


def test_subtract():
    assert subtract(5, 3) == 2


def test_multiply():
    assert multiply(2, 3) == 6


def test_divide():
    assert divide(6, 2) == 3


def test_divide_by_zero():
    with pytest.raises(ValueError):
        divide(5, 0)
