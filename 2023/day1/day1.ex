{:ok, contents} = File.read("seed1.txt")
contents |> String.split("\n", trim: true)

def calib_val()
sub("^\\D+(\\d+).*", "\\1", digs)
