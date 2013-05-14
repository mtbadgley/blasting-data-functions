using System;
using System.Text.RegularExpressions;

namespace NPIRemediation
{
    public class NPIRemediation
    {
        public bool FindMatch(string evaluate, string pattern)
        {
            return Regex.IsMatch(evaluate, pattern);
        }

        public string Replace(string original, string pattern, string mask)
        {
            string result;
            string maskedvalue = String.Empty;

            string found = Regex.Match(original, pattern).ToString();

            if (found.Length > 0)
            {

                for (int i = 0; i < found.Length; i++)
                {
                    if (found.Substring(i,1) != " " && found.Substring(i,1) != "-")
                    {
                        maskedvalue = maskedvalue + "X";
                    } 
                    else
                    {
                        maskedvalue = maskedvalue + found.Substring(i, 1);
                    }
                }

                result = original.Replace(found, maskedvalue);
            }
            else
            {
                result = original;
            }

            return result;
        }

        public string ReplaceAll(string original, string pattern)
        {
            bool hasNPI = FindMatch(original,pattern);
            string result = original;

            while(hasNPI)
            {
                result = Replace(result, pattern, "X");
                hasNPI = FindMatch(result, pattern);
            }

            return result;
        }

        public string RemoveNPI(string original,string[] patterns)
        {
            string result = original;

            foreach(string pattern in patterns)
            {
                result = ReplaceAll(result, pattern);
            }
            
            return result;
        }
    }
}
