defmodule BankOCRTest do
  use ExUnit.Case
  doctest BankOCR

  @simple_lines (
    "    _  _     _  _  _  _  _ \n" <>
    "  | _| _||_||_ |_   ||_||_|\n" <>
    "  ||_  _|  | _||_|  ||_| _|\n"
  )

  @digit_four (
    "   " <>
    "|_|" <>
    "  |"
  )

  @digit_six (
    " _ " <>
    "|_ " <>
    "|_|"
  )

  @repeat_pattern (
    "    _     _     _     _    \n" <>
    "|_||_ |_||_ |_||_ |_||_ |_|\n" <>
    "  ||_|  ||_|  ||_|  ||_|  |\n"
  )

  @tag :pending
  test "parsing account lines" do
    assert BankOCR.Parser.parse_acct_number(@simple_lines) == {:valid, "123456789"}
  end

  test "split account lines" do
    expected = [
      @digit_four, @digit_six,
      @digit_four, @digit_six,
      @digit_four, @digit_six,
      @digit_four, @digit_six,
      @digit_four
    ]

    assert BankOCR.Parser.split_digits(@repeat_pattern) == expected
  end

  test "parse single digit" do
    assert BankOCR.Parser.parse_digit(@digit_four) == "4"
  end

  test "parse another single digit" do
    assert BankOCR.Parser.parse_digit(@digit_six) == "6"
  end
end
