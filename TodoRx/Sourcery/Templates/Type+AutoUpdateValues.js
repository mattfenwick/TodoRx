<% for (type of types.implementing.AutoUpdateValues) { -%>
extension <%- type.name %> {
	<%- type.accessLevel %> func updateValues(
<%- 
	type.storedVariables
		.map(function (member) {
			return ["\t\t\t", member.name, ": ", member.typeName.name, "? = nil"].join("")
		})
		.join(",\n")
%>) -> <%- type.name %> {
		return <%- type.name %>(
<%-
	type.storedVariables
		.map(function(member) {
			return ["\t\t\t", member.name, ": ", member.name, " ?? self.", member.name].join("")
		})
		.join(",\n")
%>)
	}
}

<% } %>