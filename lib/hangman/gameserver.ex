defmodule Hangman.Gameserver do
  use GenServer
  alias Hangman.Game, as: Game

  @me __MODULE__

  #############
  ##   API   ##
  #############
  def start(default \\ []) do #pass in new_game as default
    GenServer.start(__MODULE__, default, name: @me)
    #word_as_string #should I print the blanks when .start is called?
  end
  def word_as_string do
    GenServer.call(@me, {:word_as_string})
  end
  def make_move(guess) do
    GenServer.call(@me, {:make_move, guess})
  end

  def word_length do
    GenServer.call(@me, {:word_length})
  end
  def letters_used_so_far do
    GenServer.call(@me, {:letters_used_so_far})
  end
  def turns_left do
    GenServer.call(@me, {:turns_left})
  end


  def stop do
    GenServer.stop(@me)
  end
  def show_state do
    GenServer.call(@me, {:show_state})
  end

  ########################
  ##   Implementation   ##
  ########################
  def init(args) do
    { :ok, Game.new_game }
  end

  #calls
  def handle_call({:show_state}, _from, state) do
    { :reply, state, state}
  end
  def handle_call({:word_as_string}, _from, state) do
    { :reply, Game.word_as_string(state), state}
  end
  def handle_call({:make_move, guess}, _from, state) do
    { :reply,
    get_move_status(state, guess),
    get_move_state(state, guess)}
  end
  def handle_call({:word_length}, _from, state) do
    {:reply, Game.word_length(state), state}
  end
  def handle_call({:letters_used_so_far}, _from, state) do
    {:reply, Game.letters_used_so_far(state), state}
  end
  def handle_call({:turns_left}, _from, state) do
    {:reply, Game.turns_left(state), state}
  end

  def get_move_state(state, guess) do
    {state, status, guess} = Game.make_move(state, guess)
    state
  end
  def get_move_status(state, guess) do
    {state, status, guess} = Game.make_move(state, guess)
    status
  end


  #casts
  # def handle_cast({:make_move, guess}, state) do
  #   { :noreply, Game.make_move(state, guess)}
  # end

end
