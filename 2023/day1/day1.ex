defmodule StringUtil do
  def calib_val(str) do
    first_digit(str) + last_digit(str)
  end

  def first_digit(str) when is_binary(str) do
    ret_digit(str)
  end

  def last_digit(str) when is_binary(str) do
    ret_digit(String.reverse(str))
  end

  defp ret_digit(<<c :: utf8, _rest :: binary>>) when c in ?0..?9 do
    c
  end

  defp ret_digit(<<_c :: utf8, rest :: binary>>) do
    ret_digit(rest)
  end
end

defmodule Mathieu do
  def calib_val(line) do
    first_num = String.sub("^\\D+(\\d+).*", "\\1", line)
    last_num = String.reverse(line) |> String.sub("^\\D+(\\d+).*", "\\1")
    first_num + last_num
  end
end

{:ok, contents} = File.read("seed1.txt")
lines = String.split(contents, "\n", trim: true)
values = Enum.map(lines, &StringUtil.calib_val/1)
# sum = contents |>  |>  |>
IO.inspect(StringUtil.last_digit("asdfghjkfvjr28vw2893asdf7ghjkl"))

IO.puts Enum.sum(values)
