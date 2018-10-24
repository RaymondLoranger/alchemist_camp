"File to count the words from (h for help):\n"
|> IO.gets()
|> String.trim()
|> case do
  "h" ->
    IO.write("""
    Usage: [filename] -[flags]
    Flags
    -l     displays line count
    -c     displays character count
    -w     displays word count (default)
    Multiple flags may be used. Example to display line and character counts:

    somefile.txt -lc
    """)

  line ->
    {filename, flags} =
      case String.split(line, "-", trim: true) do
        [filename, chars] -> {filename, String.codepoints(chars)}
        [filename] -> {filename, ["w"]}
      end

    {line_count, word_count, char_count} =
      for line <- File.stream!(filename) do
        {if(line =~ ~r/\n$/, do: 1, else: 0),
         line |> String.split(~r/(\n$|_|[^\w])+/, trim: true) |> length(),
         String.length(line)}
      end
      |> Enum.reduce({1, 0, 0}, fn {line_num, word_num, char_num},
                                   {line_sum, word_sum, char_sum} ->
        {line_num + line_sum, word_num + word_sum, char_num + char_sum}
      end)

    Enum.each(flags, fn flag ->
      case flag do
        "l" -> IO.puts("Lines: #{line_count}")
        "w" -> IO.puts("Words: #{word_count}")
        "c" -> IO.puts("Chars: #{char_count}")
        _ -> :ok
      end
    end)
end
