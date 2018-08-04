defmodule Markdown do
  @doc """
    Parses a given string with Markdown syntax and returns the associated HTML for that string.

    ## Examples

    iex> Markdown.parse("This is a paragraph")
    "<p>This is a paragraph</p>"

    iex> Markdown.parse("#Header!\n* __Bold Item__\n* _Italic Item_")
    "<h1>Header!</h1><ul><li><em>Bold Item</em></li><li><i>Italic Item</i></li></ul>"
  """

  import String, only: [starts_with?: 2, ends_with?: 2, trim_leading: 2, trim_trailing: 2]

  @spec parse(String.t()) :: String.t()
  def parse(text_in_markdown) do
    text_in_markdown
    |> String.split("\n")
    |> Enum.map(&process/1)
    |> Enum.join()
    |> patch()
  end

  defp process("#" <> _ = t), do: render_md_header(t)
  defp process("* " <> t), do: render_md_list_item(String.split(t))
  defp process(t), do: render_md_paragraph(String.split(t))

  defp render_md_header("# " <> rest), do: "<h1>#{rest}</h1>"
  defp render_md_header("## " <> rest), do: "<h2>#{rest}</h2>"
  defp render_md_header("### " <> rest), do: "<h3>#{rest}</h3>"
  defp render_md_header("#### " <> rest), do: "<h4>#{rest}</h4>"
  defp render_md_header("##### " <> rest), do: "<h5>#{rest}</h5>"
  defp render_md_header("###### " <> rest), do: "<h6>#{rest}</h6>"

  defp render_md_list_item(words), do: "<li>#{join_words_with_tags(words)}</li>"
  defp render_md_paragraph(words), do: "<p>#{join_words_with_tags(words)}</p>"

  defp join_words_with_tags(words) do
    words
    |> Enum.map(&render_tag/1)
    |> Enum.join(" ")
  end

  defp render_tag(word) do
    cond do
      starts_with?(word, "__") -> "<strong>#{render_tag trim_leading(word, "__")}"
      starts_with?(word, "_") -> "<em>#{render_tag trim_leading(word, "_")}"
      ends_with?(word, "__") -> "#{render_tag trim_trailing(word, "__")}</strong>"
      ends_with?(word, "_") -> "#{render_tag trim_trailing(word, "_")}</em>"
      true -> w
    end
  end

  defp patch(l) do
    String.replace_suffix(
      String.replace(l, "<li>", "<ul><li>", global: false),
      "</li>",
      "</li></ul>"
    )
  end
end
