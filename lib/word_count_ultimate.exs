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
    [filename, flags] =
      case String.split(line, "-", trim: true) do
        [filename, chars] -> [filename, String.codepoints(chars)]
        [filename] -> [filename, ["w"]]
      end

    body = File.read!(filename)
    lines = String.split(body, ~r/(\r\n|\n|\r)/)
    words = String.split(body, ~r/(\\n|[^\w'])+/, trim: true)
    chars = String.split(body, "", trim: true)

    Enum.each(flags, fn flag ->
      case flag do
        "l" -> IO.puts("Lines: #{Enum.count(lines)}")
        "w" -> IO.puts("Words: #{Enum.count(words)}")
        "c" -> IO.puts("Chars: #{Enum.count(chars)}")
        _ -> :ok
      end
    end)
end
