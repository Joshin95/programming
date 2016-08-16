-module(control).
-compile(export_all).


aplana([])->[];

aplana([H|C]) when is_list(H) -> aplana(H++C);
				       
aplana([H|C]) -> [H]++aplana(C).
