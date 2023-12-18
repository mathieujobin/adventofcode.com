defmodule StringUtil do
  require String

  def calib_val(str) do
    first_digit(str) + last_digit(str)
  end

  def first_digit(str) do
    str |> String.reverse() |> last_digit()
  end

  def last_digit(str) do
    # Remove non-digit characters from the end of the string
    cleaned_str = String.replace_trailing(str, ~r/\D+$/, "")

    # Get the last character from the cleaned string
    last_char = String.at(cleaned_str, String.length(cleaned_str) - 1)

    # Convert the last character to an integer
    last_digit = String.to_integer(last_char)

    last_digit
  end
end

defmodule Mathieu do
  require String

  def calib_val(line) do
    first_num = String.sub("^\\D+(\\d+).*", "\\1", line)
    IO.puts(first_num)
    last_num = String.reverse(line) |> String.sub("^\\D+(\\d+).*", "\\1")
    IO.puts(last_num)

    first_num + last_num
  end
end

{:ok, contents} = File.read("seed1.txt")
lines = String.split(contents, "\n", trim: true)
values = Enum.map(lines, &Mathieu.calib_val/1)
# sum = contents |>  |>  |>
IO.inspect(StringUtil.last_digit("asdfghjkfvjr28vw2893asdf7ghjkl"))

IO.puts Enum.sum(values)
