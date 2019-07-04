This is bash script that creates a hierarchy of random files and directories. It may be useful for testing applications, which include the exchange of data files and folders.

**Execution command:**

./create_infiles.sh dir_name num_of_files num_of_dirs lev

-dir_name: The directory that this hierarchy will be created at.

-num_of_files: The total amount of files needed.

-num_of_dirs: The total amount of directories needed.

-lev: The amount of levels the directories will be distributed.

**Use:**

1. If the dir_name does not exist, the script creates it.

2. It creates the directories level-by-level, until it creates num_of_dirs directories. The names of the directories are random alphanumeric values between 1 and 8 bytes.

    For examples if the num_of_dirs is 5 (ex. aaa, bbb, cc, dddd, eee), and lev is 2 then the hierarchy will look like this:
      a.dir_name/aaa/
      
      b.dir_name/aaa/bbb
      
      c.dir_name/cc/
      
      d.dir_name/cc/dddd
      
      e.dir_name/ee
      
 3. It creates num_of_files files, which are distributed in a round-robin manner at all directories. The names of the files are random alphanumeric values between 1 and 8 bytes. They contain random alphanumeric data between 1kb and 128kb.
 
    For example if num_of_files is 10 and there is the hierarchy of files provided above then the distribution of files will look like this:
      
      a.dir_name/f1
      
      b.dir_name/f7
      
      c.dir_name/aaa/f2
      
      d.dir_name/aaa/f8
      
      e.dir_name/aaa/bbb/f3
      
      f.dir_name/aaa/bbb/f9
      
      g.dir_name/cc/f4
      
      h.dir_name/cc/f10
      
      i.dir_name/cc/dddd/f5
      
      j.dir_name/eee/f6

**Except the main part of the script, three helpful fuctions where created:**
 
 1. RandomString(): Used to name the directories/files. In the script we have a global array, containing all digits, capital and lower-case letters of the english alphabet. So this function, randomly picks a size for the name, and then randomly picks this many values from the global array for the actual name of file.
 2. RandomData(): Created a random string of size between 1kb and 128kb, again, using random values from the array descripted above.
 3. Files_in_Directories(): This is a recursive function that in a round-robin manner distributes files in the sub-directories of a folder provided.
