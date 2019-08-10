import Foundation


func charAt(_ pos: Int,_ from: String) -> Character
{
    let temp = from;
    let index = temp.index(temp.startIndex, offsetBy: pos);
    return (temp[index])
}

func printPopulatedScreen(view: String)
{
    system("cls") 
    print(view)
    var i = 1;
    var once =  true;
    while ( i < 81)
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

func solve()
{
    var solve;
    while (solve == false)
    {
        solve();
    }

}

func startup() -> String
{
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
        return(input1)
    }

    return(input1)
}




let bob = startup();
printPopulatedScreen(view: bob);

let wait = readLine();
