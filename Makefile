GRAPH=graph/typetree
graph:$(GRAPH).png
$(GRAPH).png: $(GRAPH).dot
	dot -Tpng $(GRAPH).dot -o $(GRAPH).png
