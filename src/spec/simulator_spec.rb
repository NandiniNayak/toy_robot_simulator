require_relative '../lib/simulator'
require_relative '../lib/table'
require_relative '../lib/robot'


describe Robot do

  before(:each) do
    @table = Table.new 5, 5
    @robot = Robot.new @table
    @simulator = Simulator.new()
  end


  it 'should discard other commands before place' do
    expect(@simulator.run("move")).to eq("place command must be run first")
    expect(@simulator.run("left")).to eq("place command must be run first")
    expect(@simulator.run("right")).to eq("place command must be run first")
  end

  it 'should raise exceptions' do
    expect { @robot.place(6, 10, :east) }.to raise_error(IndexError)
    expect { @robot.place(1, 1, :nor) }.to raise_error(TypeError)
    expect { @robot.place(1) }.to raise_error(ArgumentError)
    expect { @robot.place(6, 6, :west)}.to raise_error("choose index between 0..4")
  end

  it 'is placed correctly' do
    expect(@robot.place(0, 1, :north)).to eq("done")
    expect(@robot.place(2, 2, :south)).to eq("done")
  end

  it 'moves on the table' do
    @robot.place(0, 0, :north)

    expect(@robot.move).to eq("done")
    expect(@robot.current_position[:posx]).to eq(0)
    expect(@robot.current_position[:posy]).to eq(1)
    expect(@robot.current_position[:direction]).to eq(:north)

    @robot.place(1, 2, :east)
    @robot.move
    @robot.move
    @robot.turn(:left)
    @robot.move

    expect(@robot.current_position[:posx]).to eq(3)
    expect(@robot.current_position[:posy]).to eq(3)
    expect(@robot.current_position[:direction]).to eq(:north)

  end

  it 'should rotate right' do
    @robot.place(0, 0, :north)
    @robot.turn(:right)
    expect(@robot.current_position[:direction]).to eq(:east)
    @robot.turn(:right)
    expect(@robot.current_position[:direction]).to eq(:south)
    @robot.turn(:right)
    expect(@robot.current_position[:direction]).to eq(:west)
    @robot.turn(:right)
    expect(@robot.current_position[:direction]).to eq(:north)
    @robot.turn(:right)
    expect(@robot.current_position[:direction]).to eq(:east)
  end

  it 'should rotate left' do
    @robot.place(0, 0, :north)
    @robot.turn(:left)
    expect(@robot.current_position[:direction]).to eq(:west)
    @robot.turn(:left)
    expect(@robot.current_position[:direction]).to eq(:south)
    @robot.turn(:left)
    expect(@robot.current_position[:direction]).to eq(:east)
    @robot.turn(:left)
    expect(@robot.current_position[:direction]).to eq(:north)
    @robot.turn(:left)
    expect(@robot.current_position[:direction]).to eq(:west)
  end

  it 'shouldn\'t exit the table' do
    @robot.place(1, 4, :north)
    expect{@robot.move}.to raise_error(/invalid move/)
  end

  it 'should report its position' do
    @robot.place(5, 5, :east)
    expect(@robot.report).to eq("5,5,EAST")
    @robot.move
    expect(@robot.report).to eq("6,5,EAST")
    @robot.turn(:right)
    @robot.move
    expect(@robot.report).to eq("6,4,SOUTH")
  end


  it 'should ignore invalid commands' do
    expect { @simulator.run("PLACE12NORTH") }.to raise_error(ArgumentError)
    expect { @simulator.run("LEFFT") }.to raise_error(ArgumentError)
    expect { @simulator.run("RIGHTT") }.to raise_error(ArgumentError)
  end

end