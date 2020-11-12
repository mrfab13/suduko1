//
// Bachelor of Software Engineering
// Media Design School
// Auckland
// New Zealand
//
// (c) 2019 Media Design School.
//
// File Name    : main.swift
// Description    : everything
// Author        : vaughan webb (8091)
// Mail            : vaughanw2012@gmail.com
//


//generic import stuffs
import Foundation

//swaps the posion of 2 string
extension String
{
    mutating func swapAt(_ pos1: Int, _ pos2: Int)
    {
        var characters = Array(self)
        characters.swapAt(pos1, pos2)
        self = String(characters)
    }
}

//finds the charactr at
func charAt(_ pos: Int,_ from: String) -> Character
{
    let temp = from;
    let index = temp.index(temp.startIndex, offsetBy: pos);
    return (temp[index])
}

//goes through the string and prints out the grid fileld in with the values
func printPopulatedScreen(view: String)
{
    print(view)
    var i = 1;
    var once =  true;
    while ( i < 82)
    {
        if (view.count > i)
        {
            var temp = charAt(i, view);
            
            if (temp == "0")
            {
                temp = " ";
            }
            print(temp, terminator:"");
        }
        else
        {
            print(" ", terminator:"");
            
        }
        if (once == true)
        {
            once = false;
        }
        else
        {
            if (i % 9 == 0)
            {
                print("");
            }
        }
        
        if (i % 9  == 3 || i % 9  == 6)
        {
            print("|" , terminator:"");
        }
        if (i == 27 || i == 54)
        {
            print("-----------");
        }
        i+=1;
    }
}

//contins the menu stuff and takes input to decide if the user wants to manually add it or genrate it.
func startup() -> String
{
    for _ in 0..<100{print("")}
    print("1) manually enter numbers")
    print("2) automaticly generate numbers")
    let input1 = readLine()!
    
    if (input1 == "1")
    {
        var i = 0;
        var godstring = " ";
        var godstring2 = " ";
        
        while (i < 9)
        {
            for _ in 0..<100{print("")}
            print("type the \(i + 1) th line (1-9 and 0 being blank)");
            var input2 = readLine()!
            
            while (input2.count < 9)
            {
                input2.append("0");
            }
            godstring2.append(input2);
            for _ in 0..<100{print("")}
            printPopulatedScreen(view: godstring2);
            print("\n1) redoline");
            if (i == 8)
            {
                print("2) solve");
            }
            else
            {
                print("2) nextline");
            }
            let input3 = readLine()!
            if (input3 == "1")
            {
                godstring2 = godstring;
            }
            if (input3 == "2")
            {
                godstring = godstring2;
                i += 1;
            }
            
        }
        return(godstring)
        
    }
    if (input1 == "2")
    {
        while (true)
        {
            var godstring = ""
            godstring = generatestring();
            print("enter 1 to continue and 2 to reroll")
            let accept = readLine();
            
            if (accept == "1")
            {
                return(godstring)
            }
        }
    }
    
    return(input1)
}


//converts the string on numbes to a 2d array
func stringtoarr(chad: String) -> Array<Array<Int>>
{
    var ans = Array(repeating: Array(repeating: 0, count: 9), count: 9)
    var x = 0;
    var y = 0;
    var count = 1;
    
    while (y < 9)
    {
        while (x < 9)
        {
            let temp1 = String(charAt(count, chad));
            let temp2 = Int(temp1)!
            ans[x][y] = (temp2);
            
            count += 1;
            x += 1;
        }
        x = 0;
        y += 1;
    }
    
    
    return(ans)
}

//randomly generates a string
func generatestring() -> String
{
    
    //new empty
    var tempgod = " "
    repeat
    {
        tempgod = " "
        for _ in 0..<81
        {
            tempgod.append("0")
        }
        
        //seed
        var i = 1
        while (i < 10)
        {
            let seed = Int.random(in: 0 ... 80)
            var temp = Array(tempgod)
            temp[seed] = Character(UnicodeScalar(i + 48)!);
            tempgod = String(temp)
            i += 1
        }
    printPopulatedScreen(view: tempgod)
        
    } while (QUnsolveable(chad: stringtoarr(chad: tempgod)) == true)
    
    //solve
    tempgod = solve(chad: stringtoarr(chad: tempgod), true)
    
    
    //Permutation
    var alt = true
    let swap = [1,2,3]
    var tempSwap = swap
    var seed = Int.random(in: 2 ... 12)
    
    for _ in 1..<seed
    {
        seed = Int.random(in: 0 ... 2)
        tempSwap = swap
        tempSwap.remove(at: seed)
        
        if (alt == true)
        {
            tempgod = boxSwap(box1:tempSwap[0] , box2:tempSwap[1] , godstring: &tempgod)
            tempgod = boxSwap(box1:tempSwap[0] + 3, box2:tempSwap[1] + 3, godstring:&tempgod)
            tempgod = boxSwap(box1:tempSwap[0] + 6, box2:tempSwap[1] + 6, godstring:&tempgod)
            
            alt = !alt
        }
        else
        {
            tempgod = boxSwap(box1:tempSwap[0] * 3, box2:tempSwap[1] * 3, godstring: &tempgod)
            tempgod = boxSwap(box1:tempSwap[0] * 3 - 2, box2:tempSwap[1] * 3 - 2, godstring:&tempgod)
            tempgod = boxSwap(box1:tempSwap[0] * 3 - 1, box2:tempSwap[1] * 3 - 1, godstring:&tempgod)
            
            alt = !alt
        }
    }
    
    //0 bomb
    var tempgod2 = Array(tempgod)
    
    seed = Int.random(in: 40 ... 60)
    var seed1 = 0
    for _ in 0..<seed
    {
        seed1 = Int.random(in: 0 ... 80)
        
        tempgod2[seed1] = "0"
    }
    
    tempgod = String(tempgod2)
    
    printPopulatedScreen(view: tempgod)
    
    return(tempgod)
}

//swaps 2 rows of boxs to make the grid look more random
func boxSwap(box1: Int, box2: Int, godstring: inout String) -> String
{
    var boxes = [box1, box2]
    var Box1A = 0
    var Box2A = 0
    
    
    //chnage to switch case
    for i in 0..<2
    {
        
        switch boxes[i]
        {
        case 1:
            
            if (i == 0)
            {
                Box1A = 1
            }
            else
            {
                Box2A = 1
            }
            
        case 2:
            
            if (i == 0)
            {
                Box1A = 4
            }
            else
            {
                Box2A = 4
            }
            
        case 3:
            
            if (i == 0)
            {
                Box1A = 7
            }
            else
            {
                Box2A = 7
            }
            
        case 4:
            
            if (i == 0)
            {
                Box1A = 28
            }
            else
            {
                Box2A = 28
            }
            
        case 5:
            
            if (i == 0)
            {
                Box1A = 31
            }
            else
            {
                Box2A = 31
            }
            
        case 6:
            
            if (i == 0)
            {
                Box1A = 34
            }
            else
            {
                Box2A = 34
            }
            
        case 7:
            
            if (i == 0)
            {
                Box1A = 55
            }
            else
            {
                Box2A = 55
            }
            
        case 8:
            
            if (i == 0)
            {
                Box1A = 58
            }
            else
            {
                Box2A = 58
            }
            
        case 9:
            
            if (i == 0)
            {
                Box1A = 61
            }
            else
            {
                Box2A = 61
            }
            
        default:
            
            print("sad beep boop")
            
        }
        
        
    }
    
    
    godstring.swapAt(Box1A, Box2A)
    godstring.swapAt(Box1A + 1, Box2A + 1)
    godstring.swapAt(Box1A + 2, Box2A + 2)
    godstring.swapAt(Box1A + 9, Box2A + 9)
    godstring.swapAt(Box1A + 10, Box2A + 10)
    godstring.swapAt(Box1A + 11, Box2A + 11)
    godstring.swapAt(Box1A + 18, Box2A + 18)
    godstring.swapAt(Box1A + 19, Box2A + 19)
    godstring.swapAt(Box1A + 20, Box2A + 20)
    
    return(godstring)
}

//converts a 2d array to the string
func arrtostring(chad: Array<Array<Int>>) -> String
{
    var ans = " "
    var x = 0 ;
    var y = 0;
    while (y < 9)
    {
        while (x < 9)
        {
            var temp1 = chad[x][y];
            temp1 += 48;
            let temp2 = Character(UnicodeScalar(temp1)!);
            ans.append(temp2);
            x += 1;
        }
        x = 0;
        y += 1;
    }
    
    return(ans);
}

//takes a array and removes the 0s from it for computational reasons
func removezeros(opt: Array<Int>) -> Array<Int>
{
    var tempopt = opt
    var i = opt.count - 1
    while (i > -1)
    {
        if (opt[i] == 0)
        {
            tempopt.remove(at: i)
        }
        i -= 1
    }
    return(tempopt)
}

//starts the depths funtion that solves the problem
func solve(chad: Array<Array<Int>>, _ IsGenration: Bool ) -> (String)
{
    var chad = chad
    var diff = 0
    var JustGiveUp = 3;
    
    print(QUnsolveable(chad:chad));
    
    while (checksolved(chad: chad) != true)
    {
        JustGiveUp = JustGiveUp - 1;
        print("solve check")
        
        let chad1 = chad
        let ans = search(chad: chad)
        chad = ans.0
        var i = 0
        
        if (ans.2.count == 0)
        {
            break;
        }
        for _ in 0..<100{print("")}
        
        
        if (chad == chad1)
        {
            diff += 1
        }
        else
        {
            diff = 0
        }
        if (diff >= 2)
        {
            let tempdepth = depth(chad: chad, ans: ans)
            if (tempdepth.1 == true)
            {
                chad = tempdepth.0;
                break
            }
            diff = 0
            i += 1
        }
        
    }
    return(arrtostring(chad:chad))
}

//checks if the function is unsolvabe
func QUnsolveable(chad: Array<Array<Int>>) -> Bool
{
    var x = 0;
    var y = 0;

    while (y < 9)
    {
        while (x < 9)
        {
            print(chad[x][y])
            if (chad[x][y] != 0)
            {
                print(x ,y)
                var possible = true
                var tempbox = BoxArray(chad: chad, X: x, Y: y);
                tempbox = removezeros(opt: tempbox);
                for i in 0...8
                {
                    if (arraycheck(minichad: tempbox, value: i) == false)
                    {
                        possible = false
                    }
                }
                tempbox = Varray(chad: chad, X: x, Y: y);
                tempbox = removezeros(opt: tempbox);
                for i in 0...8
                {
                    if (arraycheck(minichad: tempbox, value: i) == false)
                    {
                        possible = false
                    }
                }
                tempbox = Harray(chad: chad, X: x, Y: y);
                tempbox = removezeros(opt: tempbox);
                
                for i in 0...8
                    
                {
                    if (arraycheck(minichad: tempbox, value: i) == false)
                    {
                        possible = false
                    }
                }
                
                if (possible == false)
                {
                    return(true)
                }

            }
            x += 1;
        }
        y += 1;
    }
    return(false)
}

//checks the array for dublicate numbers
func arraycheck(minichad: Array<Int>, value: Int) -> Bool
{
    var count = 0
    minichad.forEach({ _ in
    if(minichad.contains(value))
    {
        count += 1
    }
    })
    if count > 1
    {
        return (false)
    }
    return (true)
}

//gets the vaulse from the suduko in a specified box
func BoxArray(chad: Array<Array<Int>>, X: Int, Y: Int) -> Array<Int>
{
    var box = [0,0];
    if (0...2).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top left
            box = [0,0];
        }
        if (3...5).contains(Y)
        {
            //middle left
            box = [0,3]
        }
        if (6...8).contains(Y)
        {
            //bottom left
            box = [0,6]
        }
    }
    if (3...5).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top middle
            box = [3,0]
            
        }
        if (3...5).contains(Y)
        {
            //middle middle
            box = [3,3]
        }
        if (6...8).contains(Y)
        {
            //bottom middle
            box = [3,6]
            
        }
    }
    if (6...8).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top right
            box = [6,0]
        }
        if (3...5).contains(Y)
        {
            //middle right
            box = [6,3]
        }
        if (6...8).contains(Y)
        {
            //bottom right
            box = [6,6]
        }
    }
    
    
    var x = 0
    var y = 0
    var temp = 0
    var temp1 = Array(repeating: 0, count: 9)
    
    while(y < 3)
    {
        while(x < 3)
        {
            temp = chad[x + box[0]][y + box[1]]
            temp1[(y * 3) + x] = temp;
            x += 1;
        }
        x = 0
        y += 1;
    }
    return(temp1)
}

//gets the vertical line of the vien posiotn
func Varray(chad: Array<Array<Int>>, X: Int, Y: Int) -> Array<Int>
{

    var i = 0;
    var temp1 = Array(repeating: 0, count: 9)
    while (i < 9)
    {
        temp1[i] = chad[X][i]
        i += 1;
    }
    
    return(temp1)
}

//get the horozontal line of the given posion
func Harray(chad: Array<Array<Int>>, X: Int, Y: Int) -> Array<Int>
{
    
    var i = 0;
    var temp1 = Array(repeating: 0, count: 9)
    while (i < 9)
    {
        temp1[i] = chad[i][Y]
        i += 1;
    }
    
    return(temp1)
}

//the depth funciton that does most of the work
func depth(chad: Array<Array<Int>>, ans : (Array<Array<Int>>, Array<Int>, Array<Int>)) -> (chad: Array<Array<Int>>, sucess: Bool)
{
    var i = 0
    var chadtemp = chad
    var diff1 = 0
    print("depth check")
    
    while (i < ans.2.count)
    {
        chadtemp[ans.1[0]][ans.1[1]] = ans.2[i]
        let chadtemp1 = chadtemp
        let ans = search(chad: chadtemp)
        chadtemp = ans.0
        //printPopulatedScreen(view: arrtostring(chad: chadtemp))
        
        if (checksolved(chad: chadtemp) == true)
        {
            return(chadtemp, true)
        }
        
        if (chadtemp == chadtemp1)
        {
            diff1 += 1
        }
        else
        {
            diff1 = 0
        }
        if (diff1 >= 2)
        {
            let tempdepth = depth(chad: chadtemp, ans: ans)
            if (tempdepth.1 == true)
            {
                return(tempdepth.0, true)
            }
            i += 1
            diff1 = 0
            chadtemp = chad
            
        }
    }
    return(chad, false)
    
}

//seares a given posion to find out what number are legal at the goven posion
func search(chad: Array<Array<Int>>) -> (chad: Array<Array<Int>>, position: Array<Int>, shortestpossibility: Array<Int>)
{
    var chad = chad
    let possibly = [1,2,3,4,5,6,7,8,9]
    //let possiblytemp = possibly;
    var possiblytemp2 = possibly;
    var shortestpossibility = possibly;
    var shortestpos = [0, 0]
    var x = 0;
    var y = 0;
    bigmomma: while (y < 9)
    {
        while (x < 9)
        {
            if (chad[x][y] == 0)
            {
                var possiblytemp = possibly;
                possiblytemp = QBoxCheck(chad: chad, X: x, Y: y, possibly: possiblytemp)
                possiblytemp2 = removezeros(opt: possiblytemp)
                if (possiblytemp2.count > 1)
                {
                    possiblytemp = QVCheck(chad: chad, X: x, Y: y, possibly: possiblytemp)
                    possiblytemp2 = removezeros(opt: possiblytemp)
                    if (possiblytemp2.count > 1)
                    {
                        possiblytemp = QHCheck(chad: chad, X: x, Y: y, possibly: possiblytemp)
                        possiblytemp2 = removezeros(opt: possiblytemp)
                        if (possiblytemp2.count > 1)
                        {
                            if (shortestpossibility.count > possiblytemp2.count)
                            {
                                shortestpossibility = possiblytemp2
                                shortestpos = [x, y]
                            }
                            
                        }
                        else if (possiblytemp2.count == 0)
                        {
                            print("problem is unsolvable, 0 possible soultions at position: ", x, ", ",y)
                            shortestpossibility = possiblytemp2
                            shortestpos = [x, y]
                            break bigmomma;
                        }
                        else
                        {
                            shortestpossibility = possiblytemp2
                            shortestpos = [x, y]
                            chad[x][y] = possiblytemp2[0]
                            break bigmomma;
                        }
                    }
                    else if (possiblytemp2.count == 0)
                    {
                        print("problem is unsolvable, 0 possible soultions at position: ", x, ", ",y)
                        shortestpossibility = possiblytemp2
                        shortestpos = [x, y]
                        break bigmomma;
                    }
                    else
                    {
                        shortestpossibility = possiblytemp2
                        shortestpos = [x, y]
                        chad[x][y] = possiblytemp2[0]
                        break bigmomma;
                    }
                }
                else if (possiblytemp2.count == 0)
                {
                    print("problem is unsolvable, 0 possible soultions at position: ", x, ", ",y)
                    shortestpossibility = possiblytemp2
                    shortestpos = [x, y]
                    break bigmomma;
                }
                else
                {
                    shortestpossibility = possiblytemp2
                    shortestpos = [x, y]
                    chad[x][y] = possiblytemp2[0]
                    break bigmomma;
                }
            }
            x += 1;
        }
        x = 0
        y += 1;
    }
    return(chad, shortestpos, shortestpossibility)
}

//checks if the puzzle is finsished
func checksolved(chad: Array<Array<Int>>) -> Bool
{
    var finished = true;
    var x = 0;
    var y = 0;
    while (y < 9)
    {
        while (x < 9)
        {
            if (chad[x][y] == 0)
            {
                finished = false;
            }
            x += 1;
        }
        x = 0
        y += 1;
    }
    return(finished);
}

//gecks what vause can go in the given posion relivitive to the box
func QBoxCheck(chad: Array<Array<Int>>, X: Int, Y: Int, possibly: Array<Int>) -> Array<Int>
{
    var box = [0,0];
    var possibly = possibly;
    if (0...2).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top left
            box = [0,0];
        }
        if (3...5).contains(Y)
        {
            //middle left
            box = [0,3]
        }
        if (6...8).contains(Y)
        {
            //bottom left
            box = [0,6]
        }
    }
    if (3...5).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top middle
            box = [3,0]
            
        }
        if (3...5).contains(Y)
        {
            //middle middle
            box = [3,3]
        }
        if (6...8).contains(Y)
        {
            //bottom middle
            box = [3,6]
            
        }
    }
    if (6...8).contains(X)
    {
        if (0...2).contains(Y)
        {
            //top right
            box = [6,0]
        }
        if (3...5).contains(Y)
        {
            //middle right
            box = [6,3]
        }
        if (6...8).contains(Y)
        {
            //bottom right
            box = [6,6]
        }
    }
    
    
    var x = 0
    var y = 0
    var temp = 0
    
    while(y < 3)
    {
        while(x < 3)
        {
            temp = chad[x + box[0]][y + box[1]]
            if (temp != 0)
            {
                possibly[temp - 1] = 0
            }
            x += 1;
        }
        x = 0
        y += 1;
    }
    return(possibly)
}

//gecks what vause can go in the given posion relivitive to the vertical
func QVCheck(chad: Array<Array<Int>>, X: Int, Y: Int, possibly: Array<Int>) -> Array<Int>
{
    
    var possibly = possibly;
    var i = 0;
    var temp = 0;
    while (i < 9)
    {
        temp = chad[X][i]
        if (temp != 0)
        {
            possibly[temp - 1] = 0
        }
        i += 1
    }
    
    return(possibly)
}

//gecks what vause can go in the given posion relivitive to the horozontal
func QHCheck(chad: Array<Array<Int>>, X: Int, Y: Int, possibly: Array<Int>) -> Array<Int>
{
    var possibly = possibly;
    var i = 0;
    var temp = 0;
    while (i < 9)
    {
        temp = chad[i][Y]
        if (temp != 0)
        {
            possibly[temp - 1] = 0
        }
        i += 1
    }
    
    return(possibly)
}



//gameplay loop
while (true)
{
    let godstring = startup();
    let godarray = stringtoarr(chad: godstring);
    printPopulatedScreen(view: solve(chad: godarray, false))
    let _ = readLine();
}



