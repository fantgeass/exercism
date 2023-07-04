# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start_link(fn -> {0, []} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn {_c, l} -> l end)
  end

  def register(pid, register_to) do
    Agent.update(pid, fn {c, l} ->
      {c + 1, [%Plot{plot_id: c + 1, registered_to: register_to} | l]}
    end)

    pid
    |> list_registrations()
    |> hd()
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn {c, l} ->
      {c, Enum.filter(l, &(&1.plot_id !== plot_id))}
    end)
  end

  def get_registration(pid, plot_id) do
    case Agent.get(pid, fn {_c, l} -> Enum.find(l, &(&1.plot_id === plot_id)) end) do
      %Plot{} = plot -> plot
      _ -> {:not_found, "plot is unregistered"}
    end
  end
end
