# -*- encoding: utf-8 -*-

"""
Modul Point

Definicio de classe i metodes
-----------------------------
"""
class Point(object):
    """
    A point on the euclidian plane represented with coordinate x and coordinate y
    """
    def distance_to_origin(self):
        """     
        >>> Point(4.0,4.0).distance_to_origin()
        5.6568542494923806
        """
        return math.sqrt(self.x*self.x+self.y*self.y)
   
    def is_inside_circle(self,r):
        """     
        >>> p=Point(4,0) 
        >>> p.is_inside_circle(1.0)
        False
        >>> p=Point(3,0) 
        >>> p.is_inside_circle(6.0)
        True
        """
        return self.distance_to_origin()<r

    def h_move(self,d):  
        """
        Setter x coordinate value is added with d
        """
        self.x+=d
    
    def v_move(self,d):      
        """
        Setter y coordinate value is added with d
        """
        self.y+=d


    def origin2(self): 
        """  
        >>> Point(4,0).origin2()
        4.0
        """
        return self.distance(Point(0,0))

    def distance(self,other):  
        """    
        >>> Point(4,0).distance(Point(2.0,2.0))
        2.8284271247461903
        """
        dx = self.x - other.x
        dy = self.y - other.y
        return math.sqrt(dx**2 + dy**2)

    def midpoint(self,p2):    
        """
        returns the Point  between Point object self and p2
        """
        mx=(self.x+p2.x)/2
        my=(self.y+p2.y)/2
        return Point(mx,my) 

    def midpoint2(p1,p2):  
        """
        returns the Point between Point p1 and Point p2
        """
        mx = (p1.x + p2.x)/2
        my = (p1.y + p2.y)/2
        return Point(mx, my)    
 
