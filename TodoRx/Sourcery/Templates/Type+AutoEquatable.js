// MARK: - AutoEquatable for structs, classes
<% for (type of types.implementing.AutoEquatable) { -%>
<% if (type.kind === "struct" || type.kind === "class") { -%>
// MARK: <%- type.name %> Equatable
extension <%- type.name %>: Equatable {
	<%- type.accessLevel %> static func ==(lhs: <%- type.name %>, rhs: <%- type.name %>) -> Bool {
	<% for (member of type.storedVariables) { -%>	guard lhs.<%- member.name %> == rhs.<%- member.name %> else { return false }
	<% } -%>
	return true
	}
}
<% } %>
<% } %>


// MARK: - AutoEquatable for Enums
<% for (type of types.implementing.AutoEquatable) { -%>
<% if (type.kind === "enum") { %>

// MARK: - <%- type.name %> AutoEquatable
extension <%- type.name %>: Equatable {
	<%- type.accessLevel %> static func ==(lhs: <%- type.name %>, rhs: <%- type.name %>) -> Bool {
		switch (lhs, rhs) {
<%-
type.cases
  .map(function(enumCase) {
    if (enumCase.hasAssociatedValue) {
      let matchLeft = enumCase.associatedValues
        .map(function(av, index) {
          return "l" + index;
        })
        .join(", ");
      let matchRight = enumCase.associatedValues
        .map(function(av, index) {
          return "r" + index;
        })
        .join(", ");
      let check = enumCase.associatedValues
        .map(function(av, index) {
          return ["l", index, " == r", index].join("");
        })
        .join(" && ");
      return [
        "case let (.", enumCase.name, "(", matchLeft, "), ",
        ".", enumCase.name, "(", matchRight, ")): return ", check
      ].join("");
    } else {
      return ["case (.", enumCase.name, ", ", enumCase.name, "): return true"].join("");
    }
  })
  .map(str => "\t\t\t" + str)
  .join("\n");
%>
			default: return false
		}
	}
}
<% } -%><% } -%>