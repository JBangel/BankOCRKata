defmodule BankOCR do
  def parse_acct_numbers_in_file(input_file) do
    input_file
    |> split_input_by_acct
    |> parse_account_numbers
    |> print
  end

  def split_input_by_acct(input_file) do
    input_file
    |> File.stream!
    |> Enum.chunk(4)
  end

  def parse_account_numbers(raw_acct_numbers) do
    raw_acct_numbers
    |> Enum.map(fn x ->
      x
      |> Enum.join("")
      |> BankOCR.Parser.parse_acct_number
    end)
  end

  def print(accounts) do
    accounts
    |> Enum.map(fn x -> stringify x end)
    |> Enum.join("")
  end

  def stringify({:valid, account}) do
    account <> "\n"
  end
end
