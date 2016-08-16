
def print_table():
    headers = ['One', 'Two', 'Three']
    table = [['test1', 2, 3.0],['test4', 5, 6.0],['test7', 8, 9.0]]
    print ''.join(column.rjust(10) for column in headers)
    for row in table:
        print ''.join(str(column).rjust(10) for column in row)
 
print_table()
