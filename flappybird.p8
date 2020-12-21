pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	game_over=false
	make_cave()
	make_player()
end

function _update()
	if (not game_over) then
		update_cave()
		move_player()
		check_hit()
	end
end

function _draw()
 cls()
 draw_cave()
 draw_player()
end
-->8
function make_player()
 player={}
 player.x=24
 player.y=60
 player.dy=0 --falling speed
 player.rise=1 --sprites
 player.fall=2
 player.dead=3
 player.speed=2
 player.score=0
end

function draw_player()
	if (game_over) then
		spr(player.dead,player.x,player.y)
	elseif (player.dy<0) then
		spr(player.rise,player.x,player.y)
	else
	 spr(player.fall,player.x,player.y)
	end
end

function move_player()
	gravity=.1
	player.dy+=gravity
	
	--jump
	if (btnp(2)) then
		player.dy-=2
	end
	
	--update player position
	player.y+=player.dy
end

function check_hit()
	for i=player.x,player.x+7 do
		if (cave[i+1].top>player.y
			or cave[i+1].btm<player.y+7) then
			game_over=true
		end			
	end
end
-->8
function make_cave()
	cave={{top=5,btm=119}}
	top=45
	btm=85
end

function update_cave()
	--remove cave column
	if (#cave>player.speed) then
		for i=1,player.speed do
			del(cave,cave[1])
		end
	end
	
	--add cave column
	while (#cave<128) do
		local col={}
		local up=flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top=mid(3,cave[#cave].top+up,top)
		col.btm=mid(btm,cave[#cave].btm+dwn,124)
		add(cave,col)
	end
end

function draw_cave()
	top_color=9
	btm_color=13
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm,btm_color)
	end
end
__gfx__
00000000003333000000020088000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033033330020020008800088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700330030030020020000880880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000033000020020000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000033000020020000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700003330002000000200880880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033000002220022008800088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000033333300022220080000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
