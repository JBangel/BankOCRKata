defmodule BankOCR.Parser do
  def parse_acct_number(_acct_string) do
    {:not_implemented_yet}
  end

  def split_digits(acct_string) do
    acct_string
    |> String.trim("\n")
    |> String.split("\n")
    |> do_split_digits([])
  end

  defp do_split_digits(["", "", ""], acc), do: acc
  defp do_split_digits([acct_line_1, acct_line_2, acct_line_3], acc) do
    {digit_part_1, rest_1} = String.split_at(acct_line_1, 3)
    {digit_part_2, rest_2} = String.split_at(acct_line_2, 3)
    {digit_part_3, rest_3} = String.split_at(acct_line_3, 3)

    digit = digit_part_1 <> digit_part_2 <> digit_part_3
    remaining = [rest_1, rest_2, rest_3]

    do_split_digits(remaining, acc ++ [digit])
  end
end
