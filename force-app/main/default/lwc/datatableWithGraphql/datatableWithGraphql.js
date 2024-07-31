// datatableWithGraphql.js
import { LightningElement, wire } from "lwc";
import { gql, graphql } from "lightning/uiGraphQLApi";

const columns = [
  { label: "Name", fieldName: "Name" },
  { label: "Phone", fieldName: "Phone", type: "phone" },
  { label: "Title", fieldName: "Title" }
];

export default class DatatableWithGraphql extends LightningElement {
  // Array of accounts to display
  contacts = undefined;
  // Errors from the wire adapter
  errors = undefined;
  // Columns for datatable
  columns = columns;

  @wire(graphql, {
    query: gql`
      query getContacts {
        uiapi {
          query {
            Contact {
              edges {
                node {
                  Id
                  Name {
                    value
                  }
                  Phone {
                    value
                  }
                  Title {
                    value
                  }
                }
              }
            }
          }
        }
      }
    `
  })
  gqlQuery({ data, errors }) {
    if (data) {
      this.contacts = data.uiapi.query.Contact.edges.map((edge) => ({
        Id: edge.node.Id,
        Name: edge.node.Name.value,
        Phone: edge.node.Phone.value,
        Title: edge.node.Title.value
      }));
    }
    this.errors = errors;
  }
}
