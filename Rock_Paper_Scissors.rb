# 變數宣告
$yourLife = 10;
$bossLife = 10;
$yourHP = "";
$bossHP = "";

# 清除Terminal的畫面
def ClearConsole()
    if RUBY_PLATFORM =~ /win32|win64|\.NET|windows|cygwin|mingw32/i
        system('cls')
    else
        system('clear');
    end
end

#執行玩家猜拳的函式，輸入1 = 剪刀 2 = 石頭 3 = 布 
def RPS()
    begin
        _Input = gets.chomp.to_i;   
    end while (_Input != 1) && (_Input != 2) && (_Input != 3) #不是輸入123的話就一直輸入下去
    return _Input;
end

#玩家輸入的值與電腦隨機產生的值來比較是否獲勝
def Fight(iPlayerInput)
    _Computer = rand(1..100) % 3 + 1;
    if (_Computer == iPlayerInput)
        return 0;
    elsif ((iPlayerInput == 1) && (_Computer == 2)) || ((iPlayerInput == 2) && (_Computer == 3)) || ((iPlayerInput == 3) && (_Computer == 1))
        return -1;
    elsif ((iPlayerInput == 1) && (_Computer == 3)) || ((iPlayerInput == 2) && (_Computer == 1)) || ((iPlayerInput == 3) && (_Computer == 2))
        return 1;
    end
end

#def LoopTime()
#   _30Frame = 1.0 / 30.0;
#   _NowTime = Time.now().to_f;
#   if _NowTime - LastTime >= _30Frame
#       LastTime = _NowTime;
#       return true;
#   else
#       return false;
#   end
#end

#計算體力值輸出為血條格式
def HP(iLife, iInverse)
    _HP = "";
   for i in 1..10
        if (i <= iLife)
            _HP += iInverse ? "|" : " ";
        else
            _HP += iInverse ? " " : "|";
        end
    end
    return _HP; 
end

# 顯示畫面資訊
def Render()#iYouHP, iBossHP, iYouLife, iBossLife)
    puts "================================="
    puts "          天下第一猜拳大會         "
    puts "================================="
    puts "You #{$yourHP} vs #{$bossHP} Boss"
    puts ""
    
    if $yourLife <= 0
        puts "              You Lose            "
    elsif $bossLife <= 0
        puts "              You Won             "
    else  
        puts ""
    end
    
    puts ""
    puts ""
end

# 戰鬥進行
def Battle()#iYouLife, iBossLife)
    if $yourLife <= 0 || $bossLife <= 0
        puts "=================================="
    else
        puts "請輸入「1. 剪刀」「2. 石頭」「3.布」來進行攻擊"

        _Input = RPS();
        _Fight = Fight(_Input);

        if _Fight == 0
            puts "平手";
        elsif _Fight == -1
            $yourLife -= 2;
            puts "你輸了，BOSS攻擊你，造成2點傷害，HP = #{$yourLife}";
        elsif _Fight == 1
            $bossLife -= 2;
            puts "你贏了，攻擊BOSS，造成2點傷害，BOSS HP = #{$bossLife}"
        end
    end
end

# 判斷玩家是否要繼續遊戲
def NextStep()#iYouLife, iBossLife)
    puts "輸入任意值繼續，或按下Ctr+C離開程式"
    _Input = gets.chomp;

    if ($yourLife <= 0) || ($bossLife <= 0)
        $yourLife = 10;
        $bossLife = 10;
    end
end

# 建立一個無窮迴圈，直到玩家輸入Ctr+C才會離開
begin
    ClearConsole();
    
    $yourHP = HP($yourLife, false);
    $bossHP = HP($bossLife, true);

    Render();#$yourHP, $bossHP, $yourLife, $bossLife);
    Battle();#$yourLife, $bossLife);
    NextStep();#$yourLife, $bossLife);
end while true