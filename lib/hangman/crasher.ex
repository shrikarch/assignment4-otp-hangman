defmodule Hangman.Crasher do
  def crash(reason) do
    GenServer.cast(@me, {:crash, reason})
  end

  def handle_cast({:crash, reason}, state) do
    {:stop, reason, state}
  end
end
