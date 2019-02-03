defmodule Exred.Node.GrpcTwinTest do
  use ExUnit.Case
  doctest Exred.Node.GrpcTwin

  use Exred.NodeTest, module: Exred.Node.GrpcTwin

  setup_all do
    start_node(Exred.Node.GrpcServer)
    start_node()
  end

  test "server up" do
    res_conn = :gen_tcp.connect('localhost', 10001, [])
    assert {:ok, sock} = res_conn

    res_close = :gen_tcp.close(sock)
    assert :ok == res_close
  end

  test "register with broker", ctx do
    me = %Exredrpc.Twin.Ex{process: self()}
    bond_id = ctx.node.config.bond_id.value

    res = Exredrpc.Broker.bond_ex(bond_id, me)
    log("registered with broker: #{inspect(res)}")
    assert res == :ok
  end

  test "receive from bonded twin" do
    me = %Exredrpc.Twin.Ex{process: self()}
    bond_id = "T2"
    res = Exredrpc.Broker.bond_ex(bond_id, me)
    log("registered with broker: #{inspect(res)}")
    assert res == :ok

    cmd = Path.join([:code.priv_dir(:exred_node_grpc_twin), "go", "client", "rpcclient"])
    {stdout, exit_code} = System.cmd(cmd, ["-bondid", bond_id])
    log("STDOUT from external client: #{stdout}")

    assert exit_code == 0
  end
end
