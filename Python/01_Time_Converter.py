#Goal: Convert integer minutes (e.g., 130) into "X hrs Y minutes".

minutes = int(input("Enter minutes: "))

#Logic:
#Hours = Total Minutes divided by 60 (integer division).
#Remaining Minutes = Total Minutes modulo (%) 60.
hours = minutes // 60 
remaining = minutes % 60

if hours == 0:
    print(f"{remaining} minutes")
elif remaining == 0:
    print(f"{hours} hrs")
else:
    print(f"{hours} hrs {remaining} minutes")

#Output:
#If hours is 0, print "Y minutes".
#If remaining minutes is 0, print "X hrs".
#Otherwise, print "X hrs Y minutes".