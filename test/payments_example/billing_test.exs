defmodule PaymentsExample.BillingTest do
  use PaymentsExample.DataCase

  alias PaymentsExample.Billing

  describe "invoices" do
    alias PaymentsExample.Billing.Invoice

    import PaymentsExample.BillingFixtures

    @invalid_attrs %{number: nil, value: nil}

    test "list_invoices/0 returns all invoices" do
      invoice = invoice_fixture()
      assert Billing.list_invoices() == [invoice]
    end

    test "get_invoice!/1 returns the invoice with given id" do
      invoice = invoice_fixture()
      assert Billing.get_invoice!(invoice.id) == invoice
    end

    test "create_invoice/1 with valid data creates a invoice" do
      valid_attrs = %{number: 42, value: 42}

      assert {:ok, %Invoice{} = invoice} = Billing.create_invoice(valid_attrs)
      assert invoice.number == 42
      assert invoice.value == 42
    end

    test "create_invoice/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Billing.create_invoice(@invalid_attrs)
    end

    test "update_invoice/2 with valid data updates the invoice" do
      invoice = invoice_fixture()
      update_attrs = %{number: 43, value: 43}

      assert {:ok, %Invoice{} = invoice} = Billing.update_invoice(invoice, update_attrs)
      assert invoice.number == 43
      assert invoice.value == 43
    end

    test "update_invoice/2 with invalid data returns error changeset" do
      invoice = invoice_fixture()
      assert {:error, %Ecto.Changeset{}} = Billing.update_invoice(invoice, @invalid_attrs)
      assert invoice == Billing.get_invoice!(invoice.id)
    end

    test "delete_invoice/1 deletes the invoice" do
      invoice = invoice_fixture()
      assert {:ok, %Invoice{}} = Billing.delete_invoice(invoice)
      assert_raise Ecto.NoResultsError, fn -> Billing.get_invoice!(invoice.id) end
    end

    test "change_invoice/1 returns a invoice changeset" do
      invoice = invoice_fixture()
      assert %Ecto.Changeset{} = Billing.change_invoice(invoice)
    end
  end
end
