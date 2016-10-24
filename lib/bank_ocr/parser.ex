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
    {res1, rest1} = String.split_at(acct_line_1, 3)
    {res2, rest2} = String.split_at(acct_line_2, 3)
    {res3, rest3} = String.split_at(acct_line_3, 3)
    do_split_digits([rest1, rest2, rest3], acc ++ [res1 <> res2 <> res3])
  end
end
