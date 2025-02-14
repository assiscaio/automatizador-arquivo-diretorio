defmodule AutomatizadorDoc do
  @dirName System.get_env("TEMPLATE_PATH")
  @baseFileName System.get_env("TEMPLATE_BASE_FILENAME")
  @replaceString System.get_env("TEMPLATE_REPLACE_STRING")

  #def dirName, do: @dirName
  #def baseFileName, do: @baseFileName
  #def replaceString, do: @replaceString

  @spec ask_task_name :: String.t()
  defp ask_task_name, do: IO.gets("Informe o código da task.\n") |> String.trim
  
  defp folder_create do
    task = ask_task_name()
    IO.inspect(task)
    IO.inspect(@dirName <> task)
    resposta = File.mkdir_p(@dirName <> task)
    case resposta do
      {:error, x} when x != :eexists -> 
        IO.inspect resposta
        raise "Ocorreu uma falha na geração do diretório."
      _ -> %{completeFullPath: @dirName <> task <> "/", task_id: task}
    end
  end

  defp copy_file_to_folder(task) do
    destinationFileCompletePath = 
      case @replaceString do
        @replaceString when is_nil(@replaceString) -> task.completeFullPath <> @baseFileName
        _ -> task.completeFullPath <> String.replace(@baseFileName, @replaceString, task.task_id)
      end
    #task.completeFullPath <> String.replace(@baseFileName, replaceString, task.task_id)
    File.cp(@baseFileName, destinationFileCompletePath)
  end

  def create_task_teste() do
    task = folder_create()
    copy_file_to_folder(task)
  end

  def main(_args) do
    create_task_teste()
  end

end