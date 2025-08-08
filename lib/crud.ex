defmodule Crud do
  use GenServer

  def start_link(value) do
    GenServer.start_link(__MODULE__, value)
  end

  def insert(pid, value) do
    GenServer.cast(pid, {:insert, value})
  end

  def view(pid) do
    GenServer.call(pid, :view)
  end


  @impl true
  def init(value) do
    {:ok, {%{0 => value}, 0}}
  end

  @impl true
  def handle_cast({:insert, value}, state) do
    {current_state, id} = state
    out_state = Map.put(current_state, id + 1, value)
    {:noreply, {out_state, id + 1}}
  end

  @impl true
  def handle_cast({:delete, key}, state) do
    {current_state, i} = state
    out_state = Map.delete(current_state, key)
    {:noreply, {out_state, i}}
  end

  @impl true
  def handle_call(:view, _, state) do
    {current_state, _} = state
    # reply, to_caller, new_state
    # in this context our to_caller and new_state are the same.
    {:reply, current_state, current_state}
  end
end
