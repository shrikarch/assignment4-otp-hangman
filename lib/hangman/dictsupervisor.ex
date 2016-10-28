defmodule Hangman.Dictionary.Supervisor do
  use Supervisor

  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end


  def init(:ok) do
    children = [
      worker(Hangman.Dictionary, [], restart: :transient)
    ]

    supervise(children, strategy: :rest_for_one)
    # opts = [strategy: :one_for_one, name: Hangman.Supervisor]
    # {:ok, _pid} = Supervisor.start_link(children, opts)
  end
end
