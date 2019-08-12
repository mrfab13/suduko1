import Foundation


func charAt(_ pos: Int,_ from: String) -> Character
{
    let temp = from;
    let index = temp.index(temp.startIndex, offsetBy: pos);
    return (temp[index])
}

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


func startup() -> String
{
    system("cls") 
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
            system("cls") 
            print("type the \(i + 1) th line (1-9 and 0 being blank)");
            var input2 = readLine()!

            while (input2.count < 9)
            {
                input2.append("0");
            }     
            godstring2.append(input2);
            system("cls") 
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
        var godstring = ""
        print("1=ez 2=med 3=hard 4=ex 5= auto")
        let input4 = readLine()!
        if (input4 == "1")
        {
            godstring = " 501627000820090013640000000960401300080730429004900500006075030200369005050000190"
        }
        if (input4 == "2")
        {
            godstring = " 200000000000000000000000000000000000000000000000000000000000000000000000000000000"
        }
        if (input4 == "3")
        {
            godstring = " 000000008300000500004300091001046750049000010070005000000400060000081004005000073"
        }
        if (input4 == "4")
        {
            godstring = " 000030002000900830100700540080004000000050080470000306000060415009501060600000000"
        }
        if (input4 == "5")
        {
            godstring = generatestring();
            print(godstring)
            let wait = readLine();
        }
        

        return(godstring)
    }

    return(input1)
}

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


            print(ans[x][y])
            count += 1;
            x += 1;
        }
        print("newline")
        x = 0;
        y += 1;
    }


    return(ans)
}

func generatestring() -> String
{
    var tempgod = " "
    for i in 0..<81
    {
        tempgod.append("0")
    }

    var i = 1
    while (i < 10)
    {
        var seed = Int((Date().timeIntervalSinceReferenceDate * 10000000000 )) % 1000
        seed *= 7 * i
        seed =  seed % 81
        print(seed)
        var temp = Array(tempgod)
        temp[seed] = Character(UnicodeScalar(i + 48)!);
        tempgod = String(temp)
        i += 1
    }

    tempgod = solve(chad: stringtoarr(chad: tempgod))

    
    //Permutation

    var tempgod2 = Array(tempgod)

    var seed = Int((Date().timeIntervalSinceReferenceDate * 10000000000 )) % 100
         seed = Int((Date().timeIntervalSinceReferenceDate * 10000000000 )) % 100

    print(seed)
    seed *= 7
    print(seed)
    seed =  seed % 20 
    print(seed)

    seed += 40
    for i in 0..<seed
    {
        var seed1 = Int((Date().timeIntervalSinceReferenceDate * 10000000000 )) % 100
        print(seed1, "big boy")
        seed1 *= 7 * i
        print(seed1, "xi")

        seed1 =  seed1 % 81
                print(seed1, " %81")

        tempgod2[seed1] = "0"
        print(seed1, "finals")

    }    

    tempgod = String(tempgod2)

    printPopulatedScreen(view: tempgod)
    readLine()

    return(tempgod)
}

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

func solve(chad: Array<Array<Int>>) -> (String)
{
    var chad = chad
    var diff = 0

    while (checksolved(chad: chad) != true)
    {
        var chad1 = chad
        var ans = search(chad: chad)
        chad = ans.0
        var i = 0

            if (ans.2.count == 0)
            {
                break;
            }
            system("cls") 
            printPopulatedScreen(view: arrtostring(chad: chad))


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
                var tempdepth = depth(chad: chad, ans: ans)
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


func depth(chad: Array<Array<Int>>, ans : (Array<Array<Int>>, Array<Int>, Array<Int>)) -> (chad: Array<Array<Int>>, sucess: Bool)
{
    var chad = chad
    var i = 0
    var chadtemp = chad
    var diff1 = 0


    while (i < ans.2.count)
    {
        chadtemp[ans.1[0]][ans.1[1]] = ans.2[i]
        var chadtemp1 = chadtemp
        var ans = search(chad: chadtemp)
        chadtemp = ans.0
        printPopulatedScreen(view: arrtostring(chad: chadtemp))

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
            var tempdepth = depth(chad: chadtemp, ans: ans)
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


func search(chad: Array<Array<Int>>) -> (chad: Array<Array<Int>>, position: Array<Int>, shortestpossibility: Array<Int>)
{
    var chad = chad
    let possibly = [1,2,3,4,5,6,7,8,9]
    var possiblytemp = possibly; 
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
                        print(possiblytemp2)
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
    solve(chad: godarray);
    let wait = readLine();
}



