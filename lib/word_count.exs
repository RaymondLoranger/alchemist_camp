"File to count the words from: "
|> IO.gets()
|> String.trim()
|> File.read!()
|> String.split(~r/(\\n|[^\w'])+/, trim: true)
|> Enum.count()
|> IO.puts()
