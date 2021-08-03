[int]$startValue = Read-Host "Enter a start value"
[int]$endValue = Read-Host "Enter an end value"
[string]$filterInput = Read-Host "Filter for 9232? (y/N)"

if ($filterInput.ToLower() -eq "y" -or $filterInput.ToLower() -eq "yes") {
    $filter9232 = $true
} else {
    $filter9232 = $false
}

class Iteration {
    [int]$value
    [int]$max
    [int]$iterations

    Iteration([int]$value) {
        $this.value = $value
        $this.max = $value
        $this.iterations = 0
    }

    [void] Step() {
        # Increment count
        $this.iterations++

        # Process value
        if ($this.value % 2) {
            # Value is ODD
            $this.value = ($this.value * 3) + 1
        } else {
            # Value is EVEN
            $this.value = $this.value / 2
        }

        # Update max if necessary
        if ($this.value -gt $this.max) {
            $this.max = $this.value
        }
    }
}

# Create empty array for Iteration objects
$iterationList = @()

for ($i = $startValue; $i -le $endValue; $i++) {
    # Instantiate new Iteration object
    $it = [Iteration]::new($i)

    do {
        $it.Step()
    } while ($it.value -ne 1)

    # Reset value to origin for publishing
    $it.value = $i

    # Add iteration to array
    $iterationList += $it
}

#clear
if ($filter9232) {
    $iterationList | Where-Object {$_.max -eq 9232} | Format-Table
} else {
    $iterationList | Format-Table
}
