import { createElement } from "lwc";
import ComboboxAutocomplete from "c/comboboxAutocomplete";

describe("c-combobox-autocomplete", () => {
  afterEach(() => {
    // The jsdom instance is shared across test cases in a single file so reset the DOM
    while (document.body.firstChild) {
      document.body.removeChild(document.body.firstChild);
    }
  });

  it("should render the component with default options", () => {
    const element = createElement("c-combobox-autocomplete", {
      is: ComboboxAutocomplete
    });
    element.options = [
      { label: "Option 1", value: "1" },
      { label: "Option 2", value: "2" },
      { label: "Option 3", value: "3" }
    ];
    document.body.appendChild(element);

    // Check if the options are rendered correctly
    const options = element.shadowRoot.querySelectorAll(
      ".slds-listbox__option-text"
    );
    expect(options).toHaveLength(3);
    expect(options[0].textContent).toBe("Option 1");
    expect(options[1].textContent).toBe("Option 2");
    expect(options[2].textContent).toBe("Option 3");
  });

  it("should filter options based on input", () => {
    const element = createElement("c-combobox-autocomplete", {
      is: ComboboxAutocomplete
    });
    element.options = [
      { label: "Option 1", value: "1" },
      { label: "Option 2", value: "2" },
      { label: "Option 3", value: "3" }
    ];
    document.body.appendChild(element);

    // Simulate user input
    const input = element.shadowRoot.querySelector("lightning-input");
    input.value = "Option 1";
    input.dispatchEvent(
      new CustomEvent("change", {
        detail: { value: "Option 1" }
      })
    );

    // Check if the options are filtered correctly
    return Promise.resolve().then(() => {
      const options = element.shadowRoot.querySelectorAll(
        ".slds-listbox__option-text"
      );
      expect(options).toHaveLength(1);
      expect(options[0].textContent).toBe("Option 1");
    });
  });

  it("should handle selecting an option", async () => {
    const element = createElement("c-combobox-autocomplete", {
      is: ComboboxAutocomplete
    });
    element.options = [
      { label: "Option 1", value: "1" },
      { label: "Option 2", value: "2" },
      { label: "Option 3", value: "3" }
    ];
    document.body.appendChild(element);

    // Register the event handler before dispatching the event
    const selectoptionHandler = jest.fn();
    element.addEventListener("selectoption", selectoptionHandler);

    // Simulate selecting an option
    const option = element.shadowRoot.querySelector(".slds-listbox__option");
    option.dispatchEvent(
      new CustomEvent("click", {
        bubbles: true,
        composed: true,
        detail: { value: "1", label: "Option 1" }
      })
    );

    // Wait for the event loop to process the event
    await Promise.resolve();

    // Check if the selectoption event is dispatched
    expect(selectoptionHandler).toHaveBeenCalled();
  });

  it("should handle no options found", () => {
    const element = createElement("c-combobox-autocomplete", {
      is: ComboboxAutocomplete
    });
    element.options = [
      { label: "Option 1", value: "1" },
      { label: "Option 2", value: "2" },
      { label: "Option 3", value: "3" }
    ];
    document.body.appendChild(element);

    // Simulate user input that results in no matches
    const input = element.shadowRoot.querySelector("lightning-input");
    input.value = "Nonexistent";
    input.dispatchEvent(
      new CustomEvent("change", {
        detail: { value: "Nonexistent" }
      })
    );

    // Check if the "No options found" message is displayed
    return Promise.resolve().then(() => {
      const noOptionsMessage = element.shadowRoot.querySelector(
        ".slds-listbox__option-text"
      );
      expect(noOptionsMessage.textContent).toBe("No options found.");
    });
  });
});
