defmodule BankOCR do
  def split_input_by_acct(input_file) do
    input_file
    |> File.stream!
    |> Enum.chunk(4)
  end
end
