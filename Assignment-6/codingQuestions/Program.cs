
using System;
using System.Linq;
using System.Text;
using System.Collections;
class codingQuestion
{
    //question 1
    static int MissingNumber(int[] arr)
    {

        int n = arr.Max();
        int sum = n * (n + 1) / 2;
        int sumofArray = 0;
        for (int i = 0; i < arr.Length; i++)
        {
            sumofArray = sumofArray + arr[i];
        }
        return sum - sumofArray;
    }
    //question 2
    static StringBuilder Compress(string inputString)
    {
        StringBuilder compressed = new StringBuilder();
        int count = 1;
        int i;
        for (i = 1; i < inputString.Length; i++)
        {
            if (inputString[i] == inputString[i - 1])
            {
                count++;
            }
            else
            {
                compressed.Append(inputString[i - 1]).Append(count);
                count = 1;
            }
        }
        compressed.Append(inputString[i - 1]).Append(count);
        return compressed;
    }

    //question 3
    static List<(int, int)> FindPairsWithSum(int[] nums, int target)
    {
        HashSet<int> seen = new HashSet<int>();
        HashSet<(int, int)> resultSet = new HashSet<(int, int)>();

        foreach (int num in nums)
        {
            int complement = target - num;

            if (seen.Contains(complement))
            {
                int first = Math.Min(num, complement);
                int second = Math.Max(num, complement);
                resultSet.Add((first, second));
            }

            seen.Add(num);
        }

        return new List<(int, int)>(resultSet);
    }

    //question 4
    static bool CompareStr(string str1, string str2)
    {
        char[] str1Array = str1.ToCharArray();
        char[] str2Array = str2.ToCharArray();
        Array.Sort(str1Array);
        Array.Sort(str2Array);
        return new string(str1Array) == new string(str2Array);
    }
    static char FirstNonRepeatingCharacter(string input)
    {
        Dictionary<char, int> charCount = new Dictionary<char, int>();

        foreach (char c in input)
        {
            if (charCount.ContainsKey(c))
                charCount[c]++;
            else
                charCount[c] = 1;
        }
        foreach (char c in input)
        {
            if (charCount[c] == 1)
                return c;
        }
        return '\0';
    }

    static int FindMajorityElement(int[] nums)
    {
        int candidate = 0, count = 0;
        foreach (int num in nums)
        {
            if (count == 0)
                candidate = num;
            count += (num == candidate) ? 1 : -1;
        }

        count = 0;
        foreach (int num in nums)
        {
            if (num == candidate)
                count++;
        }
        return (count > nums.Length / 2) ? candidate : -1;
    }
    static void Main()
    {
        int[] arr = { 1, 2, 3, 5 };
        Console.WriteLine(MissingNumber(arr));
        string inputString = "aaabbcddddd";
        Console.WriteLine(Compress(inputString));
        int[] arr1 = { 2, 7, 11, 15, -2, 4 };
        int target = 9;
        var pairs = FindPairsWithSum(arr1, target);
        foreach (var pair in pairs)
        {
            Console.WriteLine(pair);
        }
        string str1 = "listen";
        string str2 = "silent";
        Console.WriteLine(CompareStr(str1, str2));

        string input = "aabbcdeff";
        char result = FirstNonRepeatingCharacter(input);

        if (result != '\0')
            Console.WriteLine("First non-repeating character: " + result);
        else
            Console.WriteLine("No non-repeating character found.");

        int[] arr2 = { 3, 3, 4, 2, 3, 3, 3, 1 };
        int result2 = FindMajorityElement(arr2);

        if (result != -1)
            Console.WriteLine("Majority Element: " + result2);
        else
            Console.WriteLine("No Majority Element Found.");
    }
}
