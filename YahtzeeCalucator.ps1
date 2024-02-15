# Yahtzee Calculator - PowerShell
# Made by Collin Laney
# Licensed under the GNU General Public License v3.0

Add-Type -AssemblyName System.Windows.Forms

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Yahtzee Calculator"
$form.Size = New-Object System.Drawing.Size(300, 700)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedSingle'
$form.MaximizeBox = $false

# Create labels and dropdowns for upper section
$upperSectionLabels = @("Ones", "Twos", "Threes", "Fours", "Fives", "Sixes")
$upperSectionDropdowns = @()
$y = 20
foreach ($label in $upperSectionLabels) {
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Location = New-Object System.Drawing.Point(20, $y)
    $lbl.Size = New-Object System.Drawing.Size(100, 23)
    $lbl.Text = $label
    $form.Controls.Add($lbl)

    $dropdown = New-Object System.Windows.Forms.ComboBox
    $dropdown.Location = New-Object System.Drawing.Point(120, $y)
    $dropdown.Size = New-Object System.Drawing.Size(50, 23)
    $dropdown.DropDownStyle = [System.Windows.Forms.ComboBoxStyle]::DropDownList
    $dropdown.Items.AddRange(@(0, 1, 2, 3, 4, 5))
    $form.Controls.Add($dropdown)
    $upperSectionDropdowns += $dropdown

    $y += 30
}

# Create a horizontal line for visual separation
$line = New-Object System.Windows.Forms.Label
$line.Location = '20, 200'
$line.Size = New-Object System.Drawing.Size(250, 2)  # Increased width
$line.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($line)

#-------------------------------------------------------------------------

# Create labels and text boxes for the lower section
$lowerSectionLabels = @("Three of a Kind", "Four of a Kind", "Chance")
$lowerSectionTextboxes = @()
$y = 220

foreach ($label in $lowerSectionLabels) {
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.Location = New-Object System.Drawing.Point(20, $y)
    $lbl.Size = New-Object System.Drawing.Size(120, 23)
    $lbl.Text = $label
    $form.Controls.Add($lbl)

    $txt = New-Object System.Windows.Forms.TextBox
    $txt.Location = New-Object System.Drawing.Point(150, $y)
    $txt.Size = New-Object System.Drawing.Size(50, 23)
    $form.Controls.Add($txt)
    $lowerSectionTextboxes += $txt

    $y += 30
}

# Create checkboxes for Full House, Small Straight, Large Straight, and Yahtzee
$chkFullHouse = New-Object System.Windows.Forms.CheckBox
$chkFullHouse.Location = New-Object System.Drawing.Point(20, 310)
$chkFullHouse.Size = New-Object System.Drawing.Size(120, 23)
$chkFullHouse.Text = "Full House"
$form.Controls.Add($chkFullHouse)

$chkSmallStraight = New-Object System.Windows.Forms.CheckBox
$chkSmallStraight.Location = New-Object System.Drawing.Point(20, 340)
$chkSmallStraight.Size = New-Object System.Drawing.Size(120, 23)
$chkSmallStraight.Text = "Small Straight"
$form.Controls.Add($chkSmallStraight)

$chkLargeStraight = New-Object System.Windows.Forms.CheckBox
$chkLargeStraight.Location = New-Object System.Drawing.Point(20, 370)
$chkLargeStraight.Size = New-Object System.Drawing.Size(120, 23)
$chkLargeStraight.Text = "Large Straight"
$form.Controls.Add($chkLargeStraight)

$chkYahtzee = New-Object System.Windows.Forms.CheckBox
$chkYahtzee.Location = New-Object System.Drawing.Point(20, 400)
$chkYahtzee.Size = New-Object System.Drawing.Size(120, 23)
$chkYahtzee.Text = "Yahtzee"
$form.Controls.Add($chkYahtzee)

# Create a horizontal line for visual separation
$line2 = New-Object System.Windows.Forms.Label
$line2.Location = '20, 430'
$line2.Size = New-Object System.Drawing.Size(250, 2)  # Increased width
$line2.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$form.Controls.Add($line2)

#----------------------------------------------------------------------

# Create labels for upper and lower section totals
$lblUpperTotal = New-Object System.Windows.Forms.Label
$lblUpperTotal.Location = New-Object System.Drawing.Point(20, 450)
$lblUpperTotal.Size = New-Object System.Drawing.Size(200, 23)
$form.Controls.Add($lblUpperTotal)

$lblLowerTotal = New-Object System.Windows.Forms.Label
$lblLowerTotal.Location = New-Object System.Drawing.Point(20, 480)
$lblLowerTotal.Size = New-Object System.Drawing.Size(200, 23)
$form.Controls.Add($lblLowerTotal)

# Create label for upper section bonus
$lblUpperBonus = New-Object System.Windows.Forms.Label
$lblUpperBonus.Location = New-Object System.Drawing.Point(20, 510)
$lblUpperBonus.Size = New-Object System.Drawing.Size(250, 23)
$form.Controls.Add($lblUpperBonus)

# Create label for grand total
$lblGrandTotal = New-Object System.Windows.Forms.Label
$lblGrandTotal.Location = New-Object System.Drawing.Point(20, 540)
$lblGrandTotal.Size = New-Object System.Drawing.Size(200, 23)
$form.Controls.Add($lblGrandTotal)

# Create Calculate button
$btnCalculate = New-Object System.Windows.Forms.Button
$btnCalculate.Location = New-Object System.Drawing.Point(90, 570)
$btnCalculate.Size = New-Object System.Drawing.Size(100, 30)
$btnCalculate.Text = "Calculate"
$form.Controls.Add($btnCalculate)

# Event handler for the Calculate button
$btnCalculate.Add_Click({
    # Calculate upper section total
    $upperTotal = 0
    foreach ($dropdown in $upperSectionDropdowns) {
        $upperTotal += [int]$dropdown.SelectedItem * ++$i
    }
    if ($upperTotal -gt 62) {
        $upperTotal += 35
        $lblUpperBonus.Text = "Upper Section Bonus: Rewarded"
    } else {
        $lblUpperBonus.Text = "Upper Section Bonus: Not Rewarded"
    }
    $lblUpperTotal.Text = "Upper Section Total: $upperTotal"

    # Calculate lower section total
    $lowerTotal = 0
    foreach ($txt in $lowerSectionTextboxes) {
        $lowerTotal += [int]$txt.Text
    }
    $lowerTotal += 25 * ($chkFullHouse.Checked -contains $true)
    $lowerTotal += 30 * ($chkSmallStraight.Checked -contains $true)
    $lowerTotal += 40 * ($chkLargeStraight.Checked -contains $true)
    $lowerTotal += 50 * ($chkYahtzee.Checked -contains $true)
    
    $lowerTotal += [int]$txtChance.Text
    $lblLowerTotal.Text = "Lower Section Total: $lowerTotal"

    # Calculate grand total
    $grandTotal = $upperTotal + $lowerTotal

    # Display the grand total
    $lblGrandTotal.Text = "Grand Total: $grandTotal"
})

# Create a label for Mr. Collin "ColDog" Laney
$lblColDog = New-Object System.Windows.Forms.Label
$lblColDog.Location = New-Object System.Drawing.Point(160, 640)  # Adjusted location
$lblColDog.Size = New-Object System.Drawing.Size(250, 23)
$lblColDog.Text = "Made by Collin Laney"
$form.Controls.Add($lblColDog)

# Display the form
$form.ShowDialog() | Out-Null
