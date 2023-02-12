from openpyxl import load_workbook


def prepare():
    wb = load_workbook(filename="test.xlsx")
    ws = wb.active

    for row in ws:
        for cell in row:
            if cell.value == "Current":
                new_col = cell.column

    print(new_col)

    ws.insert_cols(new_col)

    wb.save("test_output.xlsx")
