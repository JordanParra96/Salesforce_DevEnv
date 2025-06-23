/**
 * @description Controller class for managing Dreamhouse Lead prospects.
 */
public with sharing class DreamhouseProspects {
  /**
   * @description The field used to sort the Lead list.
   */
  public String sortOrder { get; set; }

  /**
   * @description Retrieves a list of Leads for the Dreamhouse company, sorted by the specified field.
   * @return List of Lead records.
   */
  public List<Lead> getLeads() {
    if (sortOrder == null) {
      sortOrder = 'LastName';
    }

    return Database.query(
      'SELECT Description,Email,FirstName,Id,LastName,Phone FROM Lead WHERE Company=\'Dreamhouse\' ORDER BY ' +
      sortOrder
    );
  }

  /**
   * @description Action method to sort the Lead list.
   * @return Null page reference.
   */
  public pageReference sortList() {
    getLeads();
    return null;
  }
}
