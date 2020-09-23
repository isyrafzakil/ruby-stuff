class Mastermind
    CODES=["white", "black", "yellow", "red", "green", "blue"]
    @@i=1
    @@board=[]
    @@key_board=[]
    @@code=[]
    @@winning=false
    @@side=""
    @@coder=""
    @@breaker=""
    def self.pick_side
        puts "Enter 1 to be \"Code breaker\", or 2 to be \"Code maker\":"
        @@side=gets.chop
        if @@side=="1"
            puts "Good luck breaking the code!"
            puts "You can pick from the colors:  \"#{CODES}\""
            @@coder="computer"
            @@breaker="Player"
            self.cu_code_generator
            self.human_code_breaker
        elsif @@side=="2"
            puts "Make your best code!"
            puts "make a code from 4 slots using the colors: \"#{CODES}\""
            @@coder="Player"
            @@breaker="computer"
            self.play_turn
            self.cu_code_breaker
        else
            puts "Invalid choice, please pick again:"
            self.pick_side
        end
    end
    def self.cu_code_generator
        4.times do |i|
            if @@side=="1"
                @@code[i]=CODES[rand(6)]
            elsif @@side=="2"
                @@board[i]=CODES[rand(6)]
            end
        end
    end
    def self.play_turn
        i=1
        while i<5 do
            puts "Enter slot # #{i}"
            answer=gets.chop.downcase
            if CODES.include?(answer)
                if @@side=="1"
                    @@board[i-1]=answer
                elsif @@side=="2"
                    @@code[i-1]=answer
                end
                i+=1
            else
                puts "invalid key-color, try agian."
            end
        end
    end
    def self.check_winning
        @@code.each_with_index do |element, index|
            if element==@@board[index]
                @@winning=true
            else
                @@winning=false        
                return
            end
        end
        puts "#{@@breaker} won!"
    end
    def self.check_losing
        if @@i==12 && @@winning==false
            puts "#{@@breaker} lost, #{@@coder} won"
            puts "The code was #{@@code}"
        end
    end
    def self.give_keys
        i=0
        code=[]
        board=[]
        @@key_board=["  ", "  ", "  ", "  "]
        @@code.each_with_index {|element, index| code[index]=element}
        @@board.each_with_index {|element, index| board[index]=element}
        board.each_with_index do |element, index|
            if element==code[index]
                @@key_board[i]="red"
                i+=1
                code[index]="checked"
                board[index]="done"
            end
        end
        board.each_with_index do |element, index|
            if code.include?(element)
                @@key_board[i]="white"
                i+=1
                code[code.index(element)]="checked"
                board[index]="done"
            end
        end
        puts "turn#{@@i}: #{@@board.inspect}       keys: #{@@key_board.inspect}"
    end

    def self.human_code_breaker
        puts "You have 12 turns to guess the code"
        while @@i<13 && @@winning==false
            self.play_turn
            self.give_keys
            self.check_winning
            self.check_losing
            @@i+=1
        end
    end
    def self.cu_code_breaker
        cu_turns={}
        possibe_per_index={}
        perfect_guess=["x", "x", "x", "x"]
        key_board=[]
        count_red=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        count_flags=[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        possible_colors=["white", "black", "yellow", "red", "green", "blue"]
        new_peg=""
        removed_peg=""
        already_four=""
        r=rand(4)
        switch="off"
        4.times do |i|
            possibe_per_index["index#{i}"]=[]
        end
        while @@i<13 && @@winning==false
            possible_colors_copy=[]
            cu_turns["turn#{@@i}"]=[]
            puts "possible colors: #{possible_colors}" 
            perfect_guess.each_with_index {|element, index| (cu_turns["turn#{@@i}"])[index]=element}  # initial values for this turn.
            if @@i==1
                puts " doing turn 1 randomly"
                self.cu_code_generator
                @@board.each_with_index {|element, index| (cu_turns["turn#{@@i}"])[index]=element}
            else
                if @@i>2
                    if count_red[@@i-1]-count_red[@@i-2]==1
                        puts "we have a perfect guess here!"
                        if switch=="off"
                            perfect_guess[r]=new_peg
                        else
                            switch=="off"
                        end
                    elsif count_red[@@i-1]-count_red[@@i-2]==2
                        perfect_guess[r]=new_peg
                        switch=="off"
                    elsif count_red[@@i-1]<count_red[@@i-2]
                        if switch=="off"
                            switch="on"
                        end
                        puts "we have a perfect guess here!"
                        perfect_guess[r]=removed_peg
                    elsif count_red[@@i-1]==count_red[@@i-2]
                        (possibe_per_index["index#{r}"]).push(removed_peg)
                        (possibe_per_index["index#{r}"]).push(new_peg)
                    end
                    perfect_guess.each_with_index {|element, index| (cu_turns["turn#{@@i}"])[index]=element}
                    if count_flags[@@i-1]>count_flags[@@i-2] # the new peg is part of the code, removed peg is not
                        x=0
                        cu_turns["turn#{@@i-2}"].each do |element|
                            if element==removed_peg
                                x+=1
                            end
                        end
                        if x==1
                            possible_colors.delete(removed_peg)
                        else
                            (possibe_per_index["index#{r}"]).push(removed_peg)
                        end
                        if count_red[@@i-1]==count_red[@@i-2]
                            possible_colors.push(new_peg)
                        end
                    elsif count_flags[@@i-1]<count_flags[@@i-2]     # new peg is not part of the code, removed peg is
                        x=0
                        cu_turns["turn#{@@i-1}"].each do |element|
                            if element==new_peg
                                x+=1
                            end
                        end
                        if x==1
                            possible_colors.delete(new_peg)
                        end
                    end
                end
                if @@i>1                                    # to make sure there are at least 1 previous turn
                    i=0
                    while i<1
                        pick=possible_colors[rand(possible_colors.length)]
                        puts "becareful! last perfect is #{perfect_guess}"
                        if (cu_turns["turn#{@@i}"])[r]=="x"
                            if !(possibe_per_index["index#{r}"]).include?(pick)
                                removed_peg=(cu_turns["turn#{@@i-1}"])[r]
                                new_peg=pick
                                if (cu_turns["turn1"])[r]!=new_peg
                                    (possibe_per_index["index#{r}"]).push(new_peg)
                                end
                                (cu_turns["turn#{@@i}"])[r]=new_peg
                                puts "this should happen once"
                                i+=1
                            end
                        else
                            r=rand(4)
                        end
                    end
                end
                (cu_turns["turn#{@@i}"]).each_with_index do |element, index|
                    if element=="x"
                        (cu_turns["turn#{@@i}"])[index]=(cu_turns["turn#{@@i-1}"])[index]
                    end
                end
            end
            (cu_turns["turn#{@@i}"]).each_with_index {|element, index| @@board[index]=element}
            self.give_keys
            @@key_board.each_with_index {|element, index| key_board[index]=element}
            key_board.each_with_index do |element, index|        #count how many red or white flags we have in this turn
                if element=="white"
                    count_flags[@@i]+=1
                elsif element=="red"
                    count_red[@@i]+=1
                    count_flags[@@i]+=1
                end
            end
            self.check_winning
            self.check_losing
            puts "Hit \"Enter\" for next turn"
            gets
            @@i+=1
        end
    end
    self.pick_side
end