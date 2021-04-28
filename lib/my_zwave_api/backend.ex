defmodule MyZwaveApi.Backend do
  use GenServer

  @me __MODULE__
  def init({:ok, base_url}) do
    {:ok, { base_url, true }}
  end

  def get(path) do
    GenServer.call(@me, {:get, path})
  end

  def post(path, body) do
    GenServer.call(@me, {:post, path, body})
  end

  def live? do
    GenServer.call(@me, {:live?})
  end

  def set_live(live) do
    GenServer.cast(@me, {:set_live, live})
  end

  def start_link(base_url) do
    GenServer.start_link(@me, { :ok, base_url}, name: @me)
  end

  def handle_call({:get, path}, _from, { base_url, is_live }) do
    response = HTTPoison.get!(build_url(base_url, path))

    json = Poison.decode(response.body)

    { :reply, %{ status_code: response.status_code, json: json }, { base_url, is_live } }
  end

  def handle_call({:live?}, _from, {base_url, is_live }) do
    { :reply, is_live, { base_url, is_live } }
  end

  def handle_call({:post, path, body}, _from, {base_url, is_live}) do
    if is_live do
      response = HTTPoison.post!(build_url(base_url, path), body)

      json = Poison.decode(response.body)

      { :reply, %{status_code: response.status_code, json: json }, { base_url, is_live } }
    else
      { :reply, %{status_code: 200, json: { :ok, %{} }}, { base_url, is_live } }
    end
  end

  def handle_cast({:set_live, live}, {base_url, _}) do
    { :noreply, { base_url, live }}
  end

  def build_url(base_url, path) do
    "http://#{base_url}#{path}"
  end
end
