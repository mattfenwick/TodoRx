<% if (types.implementing.AutoInit) { -%>
<% for (type of types.implementing.AutoInit) { -%>
extension <%- type.name %> {
	<%- type.accessLevel %> init(
<%- 
	type.storedVariables
		.map(function (member) {
			return ["\t\t\t", member.name, ": ", member.typeName.name].join("")
		})
		.join(",\n")
%>) {
	<% for (member of type.storedVariables) { -%>
	self.<%- member.name %> = <%- member.name %>
	<% } -%>
}
}

<% } %>
<% } %>