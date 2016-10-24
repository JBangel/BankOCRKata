defmodule BankOCRTest do
  use ExUnit.Case
  doctest BankOCR

  @simple_lines (
    "    _  _     _  _  _  _  _ \n" <>
    "  | _| _||_||_ |_   ||_||_|\n" <>
    "  ||_  _|  | _||_|  ||_| _|\n"
  )

  @varied_lines (
    "       _  _  _  _  _  _  _ \n" <>
    "  ||_| _||_| _| _|| | _||_|\n" <>
    "  |  | _| _||_ |_ |_| _| _|\n"
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

  test "parsing simple account lines" do
    assert BankOCR.Parser.parse_acct_number(@simple_lines) == {:valid, "123456789"}
  end

  test "parsing complex account lines" do
    assert BankOCR.Parser.parse_acct_number(@varied_lines) == {:valid, "143922039"}
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

  test "Reading file and splitting by 4 line groups" do
    count_account_numbers = "test/read_testfile.txt"
    |> BankOCR.split_input_by_acct
    |> Enum.count

    assert count_account_numbers == 3
  end

  test "Parse complete file" do
    assert BankOCR.parse_acct_numbers_in_file("test/read_testfile.txt") == (
      "333333333\n" <>
      "555555555\n" <>
      "123456789\n"
    )
  end
end
