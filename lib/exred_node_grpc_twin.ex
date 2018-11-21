defmodule Exred.Node.GrpcTwin do
  @moduledoc """
  Represents an external node that connects to Exred via gRPC.
  It needs the gRPC Daemon Node running in the flow.

  External nodes can connect to Exred using the gRPC protocol.
  The external client needs to implement the exredrpc protocol
  (see the exredrpc.proto file under the priv dir).

  The protocol is a simple bi-directional streaming protocol.
  Both the internal Exred node (this node) and the external node needs to connect to the broker using a bond_id.
  Once the two sides are bonded the Broker will start forwarding messages between them.

  The external node just needs to make the RPC call and pass in the bond_id in the context as metadata.
  The gRPC server on the Elixir side will initiate the bonding for the external node.
  """

  @name "gRPC Twin"
  @category "function"
  @info @moduledoc
  @config %{
    name: %{
      info: "Visible name",
      value: @name,
      type: "string",
      attrs: %{max: 30}
    },
    bond_id: %{
      info: "Common id used by this node and the external node to establish the connection",
      value: "",
      type: "string",
      attrs: %{max: 15}
    }
  }
  @ui_attributes %{left_icon: "extension"}

  use Exred.NodePrototype

  require Logger

  @impl true
  def node_init(state) do
    me = %Exredrpc.Twin.Ex{process: self()}
    bond_id = state.config.bond_id.value

    case Exredrpc.Broker.bond_ex(bond_id, me) do
      :ok ->
        Logger.info("registered with Broker using bond_id #{inspect(bond_id)}")

      {:error, err} ->
        Logger.error("failed to bond: #{inspect(err)}")
    end

    state
  end

  @impl true
  # coming from the broker, forward it out to connected nodes
  def handle_msg({:grpc_incoming, msg}, state) do
    Logger.debug("got: #{inspect(msg)}")
    {msg, state}
  end

  # coming from a node in the flow, send it to the broker to relay it out through grpc
  def handle_msg(msg, state) do
    Exredrpc.Broker.msg_from_ex(msg)
    {nil, state}
  end
end
