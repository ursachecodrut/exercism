defmodule Newsletter do
  def read_emails(path) do
    path
    |> File.read!()
    |> String.split()
  end

  def open_log(path) do
    File.open!(path, [:write])
  end

  def log_sent_email(pid, email) do
    IO.puts(pid, email)
  end

  def close_log(pid) do
    File.close(pid)
  end

  def send_newsletter(emails_path, log_path, send_fun) do
    emails = read_emails(emails_path)
    pid = open_log(log_path)

    emails
    |> Enum.each(fn email ->
      case send_fun.(email) do
        :ok -> log_sent_email(pid, email)
        :error -> nil
      end
    end)

    close_log(pid)
  end
end
